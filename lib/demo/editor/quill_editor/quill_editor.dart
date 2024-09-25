import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import 'embeds/timestamp_embed.dart';

class QuillEditorDemo extends StatefulWidget {
  const QuillEditorDemo({super.key});

  @override
  State<QuillEditorDemo> createState() => _QuillEditorDemoState();
}

class _QuillEditorDemoState extends State<QuillEditorDemo> {
  final _controller = QuillController.basic();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: QuillEditor(
              controller: _controller,
              focusNode: _focusNode,
              scrollController: _scrollController,
              configurations: QuillEditorConfigurations(
                  customStyles: const DefaultStyles(
                    paragraph: DefaultTextBlockStyle(
                      TextStyle(
                        color: Color(0xFF12102F),
                        fontSize: 14,
                        height: 1.7,
                      ),
                      HorizontalSpacing(20, 0),
                      VerticalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      null,
                    ),
                  ),
                  searchConfigurations: const QuillSearchConfigurations(
                    searchEmbedMode: SearchEmbedMode.plainText,
                  ),
                  embedBuilders: [
                    TimeStampEmbedBuilderWidget(),
                    QuillEditorImageEmbedBuilder(
                        configurations: QuillEditorImageEmbedConfigurations(
                            onImageRemovedCallback: (path) async {
                      print('Image removed: $path');
                    }, imageProviderBuilder: (context, path) {
                      // todo local img or network img
                      return NetworkImage(path);
                    })),
                  ]),
            ),
          ),
          const Divider(height: 1),
          QuillToolbar(
            configurations: QuillToolbarConfigurations(
                buttonOptions: QuillSimpleToolbarButtonOptions(
              customButtons: QuillToolbarCustomButtonOptions(
                icon: const Icon(Icons.add_alarm_rounded, size: 24),
                onPressed: () {
                  _controller.document
                      .insert(_controller.selection.extentOffset, '\n');
                  _controller.updateSelection(
                    TextSelection.collapsed(
                      offset: _controller.selection.extentOffset + 1,
                    ),
                    ChangeSource.local,
                  );

                  _controller.document.insert(
                    _controller.selection.extentOffset,
                    TimeStampEmbed(
                      DateTime.now().toString(),
                    ),
                  );

                  _controller.updateSelection(
                    TextSelection.collapsed(
                      offset: _controller.selection.extentOffset + 1,
                    ),
                    ChangeSource.local,
                  );

                  _controller.document
                      .insert(_controller.selection.extentOffset, ' ');
                  _controller.updateSelection(
                    TextSelection.collapsed(
                      offset: _controller.selection.extentOffset + 1,
                    ),
                    ChangeSource.local,
                  );

                  _controller.document
                      .insert(_controller.selection.extentOffset, '\n');
                  _controller.updateSelection(
                    TextSelection.collapsed(
                      offset: _controller.selection.extentOffset + 1,
                    ),
                    ChangeSource.local,
                  );
                },
              ),
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          QuillToolbarSelectHeaderStyleButtons(
                            options:
                                const QuillToolbarSelectHeaderStyleButtonsOptions(),
                            controller: _controller,
                          ),
                          QuillToolbarToggleStyleButton(
                            options:
                                const QuillToolbarToggleStyleButtonOptions(),
                            controller: _controller,
                            attribute: Attribute.bold,
                          ),
                          QuillToolbarToggleStyleButton(
                            options:
                                const QuillToolbarToggleStyleButtonOptions(),
                            controller: _controller,
                            attribute: Attribute.strikeThrough,
                          ),
                          QuillToolbarColorButton(
                              controller: _controller, isBackground: false),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ], // Expanded
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: FloatingActionButton(
          onPressed: () async {
            _controller.document.insert(
              _controller.selection.extentOffset,
              TimeStampEmbed(
                DateTime.now().toString(),
              ),
            );

            _controller.updateSelection(
              TextSelection.collapsed(
                offset: _controller.selection.extentOffset + 1,
              ),
              ChangeSource.silent,
            );
          },
          child: const Icon(Icons.timer),
        ),
      ),
    );
  }
}
