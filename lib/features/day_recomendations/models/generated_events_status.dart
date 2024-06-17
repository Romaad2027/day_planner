enum GenerateEventsStatus {
  initial,
  generating,
  loading,
  error;

  bool get isInitial => this == GenerateEventsStatus.initial;
  bool get isGenerating => this == GenerateEventsStatus.generating;
  bool get isLoading => this == GenerateEventsStatus.loading;
  bool get isError => this == GenerateEventsStatus.error;
}
