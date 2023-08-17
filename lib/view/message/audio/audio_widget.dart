import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/message/audio/widget/audio_loader.dart';

import '../../../constant/app_color.dart';
import '../../../constant/app_size.dart';
import '../../../constant/app_spacing.dart';

class AudioPlayerMessage extends StatefulWidget {
  final String audioSource;
  final bool isReceiverAudio;
  const AudioPlayerMessage(
      {super.key, required this.audioSource, required this.isReceiverAudio});

  @override
  State<AudioPlayerMessage> createState() => _AudioPlayerMessageState();
}

class _AudioPlayerMessageState extends State<AudioPlayerMessage>
    with WidgetsBindingObserver {
  final _audioPlayer = AudioPlayer();
  late Future<Duration?> futureDuration;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onInit();
  }

  onInit() {
    futureDuration = _audioPlayer
        .setAudioSource(AudioSource.uri(Uri.parse(widget.audioSource)));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Duration?>(
      future: futureDuration,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Align(
            alignment: widget.isReceiverAudio
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6),
              decoration: BoxDecoration(
                  borderRadius: AppRadius.regular, color: AppColors.primary),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _controlButtons(),
                  Flexible(child: _slider(snapshot.data)),
                  _durationWidget(snapshot.data),
                  HorizontalSpacing.medium,
                ],
              ),
            ),
          );
        }
        return Align(
            alignment: widget.isReceiverAudio
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: const AudioLoadingMessage());
      },
    );
  }

  Widget _durationWidget(Duration? duration) {
    return StreamBuilder(
      stream: _audioPlayer.positionStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && duration != null) {
          return StreamBuilder<bool>(
            stream: _audioPlayer.playingStream,
            builder: (context, _) {
              final audioDuration =
                  _audioPlayer.playerState.playing ? snapshot.data : duration;
              return UIHelper.textHelper(
                  text: audioDurationBuilder(audioDuration),
                  textColor: AppColors.white);
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  String audioDurationBuilder(Duration? duration) {
    if (duration == null) return "N/A";
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget _controlButtons() {
    return StreamBuilder<bool>(
      stream: _audioPlayer.playingStream,
      builder: (context, _) {
        final color =
            _audioPlayer.playerState.playing ? Colors.red : Colors.white;
        final icon =
            _audioPlayer.playerState.playing ? Icons.pause : Icons.play_arrow;
        return GestureDetector(
          onTap: () {
            if (_audioPlayer.playerState.playing) {
              pause();
            } else {
              play().whenComplete(() => reset());
            }
          },
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(icon, color: color, size: 30),
          ),
        );
      },
    );
  }

  Future<void> play() {
    return _audioPlayer.play();
  }

  Future<void> pause() {
    return _audioPlayer.pause();
  }

  Future<void> reset() async {
    await _audioPlayer.stop();
    return _audioPlayer.seek(const Duration(milliseconds: 0));
  }

  Widget _slider(Duration? duration) {
    return StreamBuilder<Duration>(
      stream: _audioPlayer.positionStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && duration != null) {
          return SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.secondary,
              inactiveTrackColor: AppColors.white,
              trackShape: const RectangularSliderTrackShape(),
              trackHeight: 4.0,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 6.0),
            ),
            child: Slider(
              activeColor: AppColors.secondary,
              min: 0,
              max: snapshot.data!.inMicroseconds ~/ duration.inMicroseconds < 1
                  ? 1
                  : snapshot.data!.inMicroseconds / duration.inMicroseconds,
              value: snapshot.data!.inMicroseconds / duration.inMicroseconds,
              onChanged: (value) {
                // if (value >= 0.0 && value <= 1.0) {
                _audioPlayer.seek(duration * value);
                // }
                // _audioPlayer.seek(duration * value);
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
