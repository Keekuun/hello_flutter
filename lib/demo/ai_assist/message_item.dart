import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final bool isAiMessage;
  final String message;
  final Widget? avatar;
  final Widget? content;

  const MessageItem(
      {super.key,
      this.isAiMessage = false,
      required this.message,
      this.avatar,
      this.content});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return FadeInUp(
      duration: const Duration(milliseconds: 1000),
      child: Align(
        alignment: isAiMessage ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 32 - 22),
          child: DecoratedBox(
              decoration: BoxDecoration(
                color: isAiMessage ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                    mainAxisAlignment: isAiMessage
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isAiMessage
                          ? const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 32,
                            )
                          : const Icon(
                              Icons.person,
                              size: 32,
                            ),
                      avatar ?? const SizedBox.shrink(),
                      SizedBox(width: isAiMessage || avatar != null ? 12 : 0),
                      content ??
                          Flexible(
                            child: Text(
                              message,
                              style: TextStyle(
                                  color:
                                      isAiMessage ? Colors.white : primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                    ]),
              )),
        ),
      ),
    );
  }
}
