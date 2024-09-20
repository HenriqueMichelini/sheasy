import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:web_socket_channel/io.dart';

class WebRTCFileTransfer {
  final Map<String, dynamic> configuration = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
    ]
  };

  late RTCPeerConnection _peerConnection;
  late RTCDataChannel _dataChannel;
  late IOWebSocketChannel _socket;

  // Connect to the signaling server
  void connectToSignalingServer() {
    _socket = IOWebSocketChannel.connect('ws://your-server-address:3000');

    // Listen for incoming offers, answers, and ICE candidates
    _socket.stream.listen((message) {
      // Parse message (offer, answer, or ICE candidate)
      Map<String, dynamic> data = message;
      if (data['type'] == 'offer') {
        _handleOffer(data);
      } else if (data['type'] == 'answer') {
        _handleAnswer(data);
      } else if (data['type'] == 'ice-candidate') {
        _handleIceCandidate(data);
      }
    });
  }

  // Initialize connection as a caller (create offer)
  Future<void> createOffer() async {
    _peerConnection = await createPeerConnection(configuration);

    _peerConnection.onIceCandidate = (candidate) {
      if (candidate != null) {
        _socket.sink.add({
          'type': 'ice-candidate',
          'candidate': candidate.toMap(),
        });
      }
    };

    RTCSessionDescription offer = await _peerConnection.createOffer();
    await _peerConnection.setLocalDescription(offer);

    _socket.sink.add({
      'type': 'offer',
      'sdp': offer.sdp,
      'type': offer.type,
    });
  }

  // Handle receiving an offer as a callee
  Future<void> _handleOffer(Map<String, dynamic> data) async {
    _peerConnection = await createPeerConnection(configuration);

    _peerConnection.onIceCandidate = (candidate) {
      if (candidate != null) {
        _socket.sink.add({
          'type': 'ice-candidate',
          'candidate': candidate.toMap(),
        });
      }
    };

    await _peerConnection
        .setRemoteDescription(RTCSessionDescription(data['sdp'], data['type']));

    RTCSessionDescription answer = await _peerConnection.createAnswer();
    await _peerConnection.setLocalDescription(answer);

    _socket.sink.add({
      'type': 'answer',
      'sdp': answer.sdp,
      'type': answer.type,
    });
  }

  // Handle receiving an answer as a caller
  Future<void> _handleAnswer(Map<String, dynamic> data) async {
    await _peerConnection
        .setRemoteDescription(RTCSessionDescription(data['sdp'], data['type']));
  }

  // Handle receiving an ICE candidate
  Future<void> _handleIceCandidate(Map<String, dynamic> data) async {
    RTCIceCandidate candidate = RTCIceCandidate(
      data['candidate']['candidate'],
      data['candidate']['sdpMid'],
      data['candidate']['sdpMLineIndex'],
    );
    await _peerConnection.addCandidate(candidate);
  }

  // Send file data via data channel
  void sendFile(Uint8List fileBytes) {
    _dataChannel.send(RTCDataChannelMessage(fileBytes));
  }

  // Close connection
  Future<void> closeConnection() async {
    await _dataChannel.close();
    await _peerConnection.close();
    _socket.sink.close();
  }
}
