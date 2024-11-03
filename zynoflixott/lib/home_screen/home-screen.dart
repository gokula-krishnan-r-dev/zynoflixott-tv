import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  // late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    animationsMap.addAll({
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 1.0),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'movieCardOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.bounceOut,
            delay: 0.0.ms,
            duration: 800.0.ms,
            begin: Offset(100.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'movieCardOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.bounceOut,
            delay: 0.0.ms,
            duration: 800.0.ms,
            begin: Offset(100.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'movieCardOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.bounceOut,
            delay: 0.0.ms,
            duration: 800.0.ms,
            begin: Offset(100.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FutureBuilder<ApiCallResponse>(
                  future: TrendingCall.call(),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }
                    final pageViewTrendingResponse = snapshot.data!;

                    return Builder(
                      builder: (context) {
                        final results = getJsonField(
                          pageViewTrendingResponse.jsonBody,
                          r'''$.results''',
                        ).toList().take(4).toList();

                        return Container(
                          width: double.infinity,
                          height: 400,
                          child: Stack(
                            children: [
                              PageView.builder(
                                controller: _model.pageViewController ??=
                                    PageController(
                                        initialPage:
                                            max(0, min(0, results.length - 1))),
                                scrollDirection: Axis.horizontal,
                                itemCount: results.length,
                                itemBuilder: (context, resultsIndex) {
                                  final resultsItem = results[resultsIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDetailsWidget(
                                            movieId: getJsonField(
                                              resultsItem,
                                              r'''$.id''',
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MovieDetailsWidget(
                                                    movieId: getJsonField(
                                                      resultsItem,
                                                      r'''$.id''',
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 400,
                                              child: custom_widgets.ImdbImage(
                                                width: double.infinity,
                                                height: 400,
                                                imagePath:
                                                    valueOrDefault<String>(
                                                  getJsonField(
                                                    resultsItem,
                                                    r'''$.backdrop_path''',
                                                  )?.toString(),
                                                  '/393mh1AJ0GYWVD7Hsq5KkFaTAoT.jpg',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0, 1.51),
                                          child: Container(
                                            width: double.infinity,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.transparent,
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground
                                                ],
                                                stops: [0, 1],
                                                begin:
                                                    AlignmentDirectional(0, -1),
                                                end: AlignmentDirectional(0, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0, -1),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 100),
                                            child: Container(
                                              width: double.infinity,
                                              height: 68,
                                              decoration: BoxDecoration(),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(15, 0, 24, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0.45),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(10, 0,
                                                                    0, 5),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                type:
                                                                    PageTransitionType
                                                                        .scale,
                                                                alignment: Alignment
                                                                    .bottomCenter,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        600),
                                                                reverseDuration:
                                                                    Duration(
                                                                        milliseconds:
                                                                            600),
                                                                child: NavBarPage(
                                                                    initialPage:
                                                                        'Search'),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0x00FFFFFF),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child:
                                                                Lottie.network(
                                                              'https://assets5.lottiefiles.com/packages/lf20_ptcOIy.json',
                                                              width: 150,
                                                              height: 130,
                                                              fit: BoxFit.cover,
                                                              animate: true,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0.45),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(10, 0,
                                                                    0, 5),
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              if (Theme.of(
                                                                          context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark) {
                                                                setDarkModeSetting(
                                                                    context,
                                                                    ThemeMode
                                                                        .light);
                                                                return;
                                                              } else {
                                                                setDarkModeSetting(
                                                                    context,
                                                                    ThemeMode
                                                                        .dark);
                                                                return;
                                                              }
                                                            },
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    if (Theme.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .light)
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            13,
                                                                            8,
                                                                            16,
                                                                            0),
                                                                        child:
                                                                            Icon(
                                                                          FFIcons
                                                                              .knameMoon,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          size:
                                                                              24,
                                                                        ),
                                                                      ),
                                                                    if (Theme.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .dark)
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            11,
                                                                            8,
                                                                            16,
                                                                            0),
                                                                        child:
                                                                            Icon(
                                                                          FFIcons
                                                                              .knameSun,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          size:
                                                                              24,
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0, 0.85),
                                          child: Container(
                                            width: double.infinity,
                                            height: 68,
                                            decoration: BoxDecoration(),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(24, 0, 20, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 8, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            getJsonField(
                                                              resultsItem,
                                                              r'''$.title''',
                                                            ).toString(),
                                                            maxLines: 1,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 20,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                          Text(
                                                            'Action Drama Adventure',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize: 12,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ],
                                                      ).animateOnPageLoad(
                                                          animationsMap[
                                                              'columnOnPageLoadAnimation']!),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0.7),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 10, 0),
                                                      child: Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: ToggleIcon(
                                                          onPressed: () async {
                                                            safeSetState(() =>
                                                                FFAppState()
                                                                        .Active =
                                                                    !FFAppState()
                                                                        .Active);
                                                          },
                                                          value: FFAppState()
                                                              .Active,
                                                          onIcon: Icon(
                                                            Icons.favorite,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 25,
                                                          ),
                                                          offIcon: Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0.7),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 10, 0),
                                                      child: Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 5),
                                                          child: ToggleIcon(
                                                            onPressed:
                                                                () async {
                                                              safeSetState(() =>
                                                                  FFAppState()
                                                                          .local =
                                                                      !FFAppState()
                                                                          .local);
                                                            },
                                                            value: FFAppState()
                                                                .local,
                                                            onIcon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .share,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 25,
                                                            ),
                                                            offIcon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .share,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 25,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0.7),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 10, 0),
                                                      child: Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: ToggleIcon(
                                                          onPressed: () async {
                                                            safeSetState(() =>
                                                                FFAppState()
                                                                        .local =
                                                                    !FFAppState()
                                                                        .local);
                                                          },
                                                          value: FFAppState()
                                                              .local,
                                                          onIcon: Icon(
                                                            FFIcons
                                                                .knameDownloadO,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 25,
                                                          ),
                                                          offIcon: Icon(
                                                            FFIcons
                                                                .knameDownloadO,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0.7),
                                                    child: Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Lottie.network(
                                                        'https://assets2.lottiefiles.com/packages/lf20_9ogBjR.json',
                                                        width: 150,
                                                        height: 130,
                                                        fit: BoxFit.cover,
                                                        animate: true,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Align(
                                alignment: AlignmentDirectional(-0.83, 0.95),
                                child:
                                    smooth_page_indicator.SmoothPageIndicator(
                                  controller: _model.pageViewController ??=
                                      PageController(
                                          initialPage: max(
                                              0, min(0, results.length - 1))),
                                  count: results.length,
                                  axisDirection: Axis.horizontal,
                                  onDotClicked: (i) async {
                                    await _model.pageViewController!
                                        .animateToPage(
                                      i,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                    safeSetState(() {});
                                  },
                                  effect:
                                      smooth_page_indicator.ExpandingDotsEffect(
                                    expansionFactor: 2,
                                    spacing: 8,
                                    radius: 16,
                                    dotWidth: 12,
                                    dotHeight: 6,
                                    dotColor: Color(0x33EF233C),
                                    activeDotColor:
                                        FlutterFlowTheme.of(context).primary,
                                    paintStyle: PaintingStyle.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Now Playing',
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0.0,
                            ),
                      ),
                      Text(
                        'See all >',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 224,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: FutureBuilder<ApiCallResponse>(
                    future: NowPlayingMoviesCall.call(),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }
                      final listViewNowPlayingMoviesResponse = snapshot.data!;

                      return Builder(
                        builder: (context) {
                          final movies = getJsonField(
                            listViewNowPlayingMoviesResponse.jsonBody,
                            r'''$.results''',
                          ).toList().take(8).toList();

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: movies.length,
                            itemBuilder: (context, moviesIndex) {
                              final moviesItem = movies[moviesIndex];
                              return Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 600),
                                        reverseDuration:
                                            Duration(milliseconds: 600),
                                        child: MovieDetailsWidget(
                                          movieId: getJsonField(
                                            moviesItem,
                                            r'''$.id''',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: MovieCardWidget(
                                    key: Key(
                                        'Keyek5_${moviesIndex}_of_${movies.length}'),
                                    imagePath: getJsonField(
                                      moviesItem,
                                      r'''$.poster_path''',
                                    ).toString(),
                                    title: getJsonField(
                                      moviesItem,
                                      r'''$.title''',
                                    ).toString(),
                                    duration: '1h 37m',
                                    rating: getJsonField(
                                      moviesItem,
                                      r'''$.vote_average''',
                                    ).toString(),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'movieCardOnPageLoadAnimation1']!),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'On TV',
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0.0,
                            ),
                      ),
                      Text(
                        'See all >',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 224,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: FutureBuilder<ApiCallResponse>(
                    future: TvShowsOnAirCall.call(),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }
                      final listViewTvShowsOnAirResponse = snapshot.data!;

                      return Builder(
                        builder: (context) {
                          final tvshows = getJsonField(
                            listViewTvShowsOnAirResponse.jsonBody,
                            r'''$.results''',
                          ).toList().take(8).toList();

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: tvshows.length,
                            itemBuilder: (context, tvshowsIndex) {
                              final tvshowsItem = tvshows[tvshowsIndex];
                              return Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                                child: FutureBuilder<ApiCallResponse>(
                                  future: TvShowsInfoCall.call(
                                    tvId: getJsonField(
                                      tvshowsItem,
                                      r'''$.id''',
                                    ),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    final movieCardTvShowsInfoResponse =
                                        snapshot.data!;

                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TvShowsDetailsWidget(
                                              tvId: getJsonField(
                                                tvshowsItem,
                                                r'''$.id''',
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: MovieCardWidget(
                                        key: Key(
                                            'Key9zx_${tvshowsIndex}_of_${tvshows.length}'),
                                        imagePath: getJsonField(
                                          tvshowsItem,
                                          r'''$.poster_path''',
                                        ).toString(),
                                        title: getJsonField(
                                          tvshowsItem,
                                          r'''$.name''',
                                        ).toString(),
                                        duration: 'S${getJsonField(
                                          movieCardTvShowsInfoResponse.jsonBody,
                                          r'''$.last_episode_to_air.season_number''',
                                        ).toString()}E${getJsonField(
                                          movieCardTvShowsInfoResponse.jsonBody,
                                          r'''$.last_episode_to_air.episode_number''',
                                        ).toString()}',
                                        rating: getJsonField(
                                          tvshowsItem,
                                          r'''$.vote_average''',
                                        ).toString(),
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'movieCardOnPageLoadAnimation2']!);
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Movies',
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0.0,
                            ),
                      ),
                      Text(
                        'See all >',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 224,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: FutureBuilder<ApiCallResponse>(
                    future: PopularMoviesCall.call(),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }
                      final listViewPopularMoviesResponse = snapshot.data!;

                      return Builder(
                        builder: (context) {
                          final popularMovies = getJsonField(
                            listViewPopularMoviesResponse.jsonBody,
                            r'''$.results''',
                          ).toList().take(8).toList();

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: popularMovies.length,
                            itemBuilder: (context, popularMoviesIndex) {
                              final popularMoviesItem =
                                  popularMovies[popularMoviesIndex];
                              return Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetailsWidget(
                                          movieId: valueOrDefault<int>(
                                            getJsonField(
                                              popularMoviesItem,
                                              r'''$.id''',
                                            ),
                                            278,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: MovieCardWidget(
                                    key: Key(
                                        'Keyrp9_${popularMoviesIndex}_of_${popularMovies.length}'),
                                    imagePath: getJsonField(
                                      popularMoviesItem,
                                      r'''$.poster_path''',
                                    ).toString(),
                                    title: getJsonField(
                                      popularMoviesItem,
                                      r'''$.title''',
                                    ).toString(),
                                    duration: '1h 37m',
                                    rating: getJsonField(
                                      popularMoviesItem,
                                      r'''$.vote_average''',
                                    ).toString(),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'movieCardOnPageLoadAnimation3']!),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
