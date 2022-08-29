class SongProgressIndicatorHandler {
  void Function()? resumeHandler;
  void Function()? pauseHandler;
  void Function()? playHandler;

  void resume() {
    resumeHandler?.call();
  }

  void pause() {
    pauseHandler?.call();
  }

  void start() {
    playHandler?.call();
  }

  void attachResumeHandler(void Function() handler) {
    resumeHandler = handler;
  }

  void attachPauseHandler(void Function() handler) {
    pauseHandler = handler;
  }

  void attachStartHandler(void Function() handler) {
    playHandler = handler;
  }
}
