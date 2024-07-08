import 'package:app/models/alert.dart';

class AlertRepository {
  static List<Alert> table = [
    Alert(
        type: 'low',
        detection: 'Tinha tomou água',
        confidence: 96.5,
        img:
            'https://s2-g1.glbimg.com/c1tS_axTjV_qDkmMeMs3wYZCgGY=/0x0:5472x3648/1008x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2017/H/v/pTatikTlSIWRuTzd0JwA/j9a6180.jpg',
        date: 'Há 5 minutos'),
    Alert(
        type: 'low',
        detection: 'Lua foi na caixa',
        confidence: 93.5,
        img:
            'https://s2-g1.glbimg.com/c1tS_axTjV_qDkmMeMs3wYZCgGY=/0x0:5472x3648/1008x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2017/H/v/pTatikTlSIWRuTzd0JwA/j9a6180.jpg',
        date: 'Há 6 minutos'),
    Alert(
        type: 'low',
        detection: 'Lua comeu ração',
        confidence: 99.9,
        img:
            'https://s2-g1.glbimg.com/c1tS_axTjV_qDkmMeMs3wYZCgGY=/0x0:5472x3648/1008x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2017/H/v/pTatikTlSIWRuTzd0JwA/j9a6180.jpg',
        date: 'Há 8 minutos'),
    Alert(
        type: 'low',
        detection: 'Tinha comeu ração',
        confidence: 89.9,
        img:
            'https://s2-g1.glbimg.com/c1tS_axTjV_qDkmMeMs3wYZCgGY=/0x0:5472x3648/1008x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2017/H/v/pTatikTlSIWRuTzd0JwA/j9a6180.jpg',
        date: 'Há 15 minutos'),
    Alert(
        type: 'low',
        detection: 'Tinha foi na caixa',
        confidence: 88.0,
        img:
            'https://s2-g1.glbimg.com/c1tS_axTjV_qDkmMeMs3wYZCgGY=/0x0:5472x3648/1008x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2017/H/v/pTatikTlSIWRuTzd0JwA/j9a6180.jpg',
        date: 'Há 25 minutos'),
  ];
}
