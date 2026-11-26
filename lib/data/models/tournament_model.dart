import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TournamentModel extends Equatable {
  final String id;
  final String name;
  final String status; // "LIVE", "UPCOMING", "COMPLETED"
  final String liveStreamUrl;
  final String totalPrize;
  final String bannerUrl;

  const TournamentModel({
    required this.id,
    required this.name,
    required this.status,
    required this.liveStreamUrl,
    required this.totalPrize,
    this.bannerUrl = '',
  });

  bool get isLive => status.toUpperCase() == 'LIVE';

  factory TournamentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return TournamentModel(
      id: doc.id,
      name: data['name'] ?? '',
      status: data['status'] ?? 'UPCOMING',
      liveStreamUrl: data['live_stream_url'] ?? '',
      totalPrize: data['total_prize'] ?? '₹0',
      bannerUrl: data['banner_url'] ?? '',
    );
  }

  factory TournamentModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return TournamentModel(
      id: id ?? map['id'] ?? '',
      name: map['name'] ?? '',
      status: map['status'] ?? 'UPCOMING',
      liveStreamUrl: map['live_stream_url'] ?? '',
      totalPrize: map['total_prize'] ?? '₹0',
      bannerUrl: map['banner_url'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'status': status,
      'live_stream_url': liveStreamUrl,
      'total_prize': totalPrize,
      'banner_url': bannerUrl,
    };
  }

  @override
  List<Object?> get props => [id, name, status, liveStreamUrl, totalPrize, bannerUrl];
}

