class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    navigateToMainScreen();
  }

  void navigateToMainScreen() async {
    // 로딩 화면 표시
    showLoadingDialog();

    try {
      // 로딩 작업 수행 (예: API 호출 등)
      await performLoadingTasks();

      // 완료 후 메인 화면으로 이동
      Navigator.pushReplacementNamed(context, '/');
    } catch (error) {
      // 에러 발생 시 처리
      print('로딩 작업 중 에러 발생: $error');
      // 에러 화면 또는 다른 대체 화면으로 이동 처리
      navigateToErrorScreen();
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<void> performLoadingTasks() async {
    // 로딩 작업 수행
    // 예시: API 호출
    // await makeAPICall();
    // 또는 다른 작업 수행
    // await performOtherTasks();
    // ...
    // 필요한 작업을 수행하세요.
    // 로딩이 완료되면 메인 화면으로 이동합니다.
  }

  void navigateToErrorScreen() {
    // 에러 화면 또는 대체 화면으로 이동하는 로직을 구현합니다.
    // 예시: Navigator.pushReplacementNamed(context, '/error');
    // 또는 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ErrorScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
