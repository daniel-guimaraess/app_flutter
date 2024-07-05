class AlertModel {
  String message;
  double confiance;

  AlertModel({required this.message, required this.confiance});

  static List<AlertModel> getAlerts() {
    List<AlertModel> alerts = [];

    alerts.add(AlertModel(message: 'Tinha foi na caixa', confiance: 99.0));

    alerts.add(AlertModel(message: 'Lua foi na caixa', confiance: 97.0));

    alerts.add(AlertModel(message: 'Tinha bebeu agua', confiance: 86.0));

    alerts.add(AlertModel(message: 'Lua bebeu agua', confiance: 83.0));

    alerts.add(AlertModel(message: 'Lua comeu ração', confiance: 95.0));

    return alerts;
  }
}
