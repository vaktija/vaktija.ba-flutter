import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/button/button_square.dart';
import 'package:vaktijaba_fl/components/divider/horizontal_divider.dart';
import 'package:vaktijaba_fl/components/models/vakat_ezan_model.dart';
import 'package:vaktijaba_fl/components/models/vakat_settings_model.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/components/vaktija_location_list_field.dart';
import 'package:vaktijaba_fl/data/app_data.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/services/vaktija_state_provider.dart';

class AthanSelectDialogue extends StatefulWidget {
  final int vakatIndex;
  final EzanModel activeAthan;

  const AthanSelectDialogue(
      {super.key, required this.vakatIndex, required this.activeAthan});

  @override
  State<AthanSelectDialogue> createState() => _AthanSelectDialogueState();
}

class _AthanSelectDialogueState extends State<AthanSelectDialogue> {
  late EzanModel selectedAthan;
  final _player = AudioPlayer();

  @override
  void initState() {
    selectedAthan = widget.activeAthan;
    super.initState();
  }

  playAthan() async {
    if(_player.playing){
      _player.stop();
    }
    await _player.setAsset(selectedAthan.path);
    await _player.play();
    print('ide');
    //_player
  }

  @override
  void dispose() {
    if(_player.playing){
      _player.stop();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateProviderVaktija vaktijaProvider =
        Provider.of<StateProviderVaktija>(context);
    VakatSettingsModel vakatSettingsModel =
        vaktijaProvider.vaktovi[widget.vakatIndex];
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(defPadding * 3),
        child: Material(
          borderRadius: BorderRadius.circular(defPadding * 2),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 350.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer, //scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(defPadding * 2),
            ),
            padding: const EdgeInsets.only(
              top: defPadding,
              right: defPadding,
              bottom: defPadding * 3,
              left: defPadding * 3,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: TextBodyMedium(
                          text: 'Postavke zvuka alarma',
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.close_outlined,
                          color: AppColors.colorAction,
                        ),
                        iconSize: defPadding * 3,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  gap16,
                  ListView.separated(
                    padding: EdgeInsets.only(right: defPadding * 2),
                    itemBuilder: (context, index) {
                      EzanModel ezan = Athans.athans[index];
                      return LocationListField(
                        index: index,
                        isChecked: selectedAthan.id == ezan.id,
                        isRadioIcon: false,
                        title: ezan.muazzin,
                        onTap: () {
                          setState(() {
                            selectedAthan = ezan;
                          });
                          playAthan();
                        },
                      );
                    },
                    separatorBuilder: (_, __) => const DividerCustomHorizontal(
                      height: 1.0,
                    ),
                    itemCount: Athans.athans.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                  gap16,
                  Padding(
                    padding: const EdgeInsets.only(
                      right: defPadding * 2,
                    ),
                    child: ButtonSquare(
                      label: 'Spasi',
                      onTap: () {
                        vakatSettingsModel.ezan = selectedAthan;
                        updateVakatSettings(
                          context,
                          vakatSettingsModel,
                          widget.vakatIndex,
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
