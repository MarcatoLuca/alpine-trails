enum PageName { home, about, contact, services, splash, login }

enum OperatorAvailability {
  unavailable('Non Disponibile'),
  busy('Disponibilità Limitata'),
  available('Disponibile Ora');

  final String displayName;
  const OperatorAvailability(this.displayName);

  static OperatorAvailability fromString(String? value) {
    for (var status in values) {
      if (status.displayName == value) {
        return status;
      }
    }
    return OperatorAvailability.unavailable;
  }
}
