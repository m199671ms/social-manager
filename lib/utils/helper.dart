import 'dart:ui' as ui;
import 'dart:io';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_manager/generated/l10n.dart';
import 'package:social_manager/models/service.dart';

class Helper {
  const Helper._();
  static final OverlayEntry _overlayLoader = OverlayEntry(
    builder: (_) => Container(
      color: Colors.black.withAlpha(100),
      key: const Key('overlay loader'),
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    ),
  );
  static late final ImageShader cracksShader;
  static Future<void> init() async {
    final bytes = await rootBundle.load('assets/images/cracks.png');
    ui.Image? image;
    ui.decodeImageFromList(bytes.buffer.asUint8List(), (result) {
      image = result;
    });
    await Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 50));
      return image == null;
    });
    cracksShader = ui.ImageShader(
      image!,
      ui.TileMode.clamp,
      TileMode.clamp,
      Matrix4.identity().storage,
    );
  }

  static void doAsync<T>({
    required Future<T> future,
    required BuildContext context,
    required void Function(T results) onDone,
    void Function(dynamic, StackTrace?)? onGenericError,
    VoidCallback? onConnectionError,
    ScaffoldState? state,
  }) async {
    state = state ?? Scaffold.of(context);
    // ignore: prefer_function_declarations_over_variables
    onGenericError = onGenericError ??
        (error, trace) {
          showConnectionError(context: context);
        };
    onConnectionError = onConnectionError ??
        () {
          showConnectionError(context: context);
        };
    _showOverlayLoader(state);
    try {
      T result = await future;
      onDone(result);
    } on DioError catch (exception, stacktrace) {
      debugPrint('On Dio Error');
      debugPrint(exception.toString());
      debugPrint(stacktrace.toString());
      if (exception.error is SocketException ||
          exception.error is HttpException) {
        onConnectionError();
      } else {
        onGenericError(exception, stacktrace);
      }
    } catch (exception, stacktrace) {
      debugPrint(exception.toString());
      debugPrint(stacktrace.toString());
      onGenericError(exception, stacktrace);
    } finally {
      try {
        _removeOverlayLoader();
        // ignore: empty_catches
      } catch (e) {}
    }
  }

  static void _showOverlayLoader(ScaffoldState state) {
    Overlay.of(state.context)?.insert(_overlayLoader);
  }

  static void _removeOverlayLoader() {
    _overlayLoader.remove();
  }

  static void showError({
    required BuildContext context,
    required String subtitle,
  }) =>
      FlushbarHelper.createError(message: subtitle, title: S.of(context).error)
          .show(context);

  static void showMessage({
    required BuildContext context,
    required String subtitle,
  }) =>
      FlushbarHelper.createSuccess(
        message: subtitle,
      ).show(context);

  static void showConnectionError({required BuildContext context}) =>
      showError(context: context, subtitle: S.of(context).connection_error);
  static Widget mediaIcon(MediaService service, {IconThemeData? theme}) =>
      IconTheme.merge(
        data: theme ??
            IconThemeData(
              color: service.iconColor,
            ),
        child: FaIcon(
          IconData(
            service.icon,
            fontFamily: service.iconFont,
            fontPackage: service.iconPackage,
          ),
        ),
      );
}
