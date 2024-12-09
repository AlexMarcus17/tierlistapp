import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/presentation/providers/tier_lists_provider.dart';
import 'package:tierlist/presentation/screens/editor_screen.dart';

class TierListCard extends StatefulWidget {
  final TierList tierList;

  const TierListCard({super.key, required this.tierList});

  @override
  State<TierListCard> createState() => _TierListCardState();
}

class _TierListCardState extends State<TierListCard> {
  bool isEditing = false;
  TextEditingController controller = TextEditingController();
  @override
  void didChangeDependencies() {
    controller.text = widget.tierList.name;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isEditing) {
          setState(() {
            controller.text = widget.tierList.name;
            isEditing = false;
          });
        }
        Navigator.of(context)
            .pushNamed(EditorScreen.routeName, arguments: widget.tierList);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: const Color(0xFF424242),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(widget.tierList.imagePath, width: 120),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isEditing
                      ? Container(
                          width: double.infinity,
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller,
                                  maxLength: 20,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                  ),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (controller.text.trim().isNotEmpty) {
                                      Provider.of<TierListsProvider>(context,
                                              listen: false)
                                          .renameTierList(widget.tierList.id,
                                              controller.text.trim());

                                      setState(() {
                                        isEditing = false;
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.check)),
                            ],
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 50,
                          child: Text(widget.tierList.name,
                              style: Theme.of(context).textTheme.titleMedium),
                        ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if (isEditing) {
                              setState(() {
                                controller.text = widget.tierList.name;
                                isEditing = false;
                              });
                            } else {
                              setState(() {
                                isEditing = true;
                              });
                            }
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () async {
                            setState(() {
                              isEditing = false;
                            });
                            bool? shouldDelete = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'Confirm Deletion',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                content: Text(
                                  'Are you sure you want to delete this tier list?',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Delete',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );

                            if (shouldDelete == true) {
                              Provider.of<TierListsProvider>(context,
                                      listen: false)
                                  .deleteUserTierList(widget.tierList.id);
                            }
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
