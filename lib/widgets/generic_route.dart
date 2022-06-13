
import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:nekodroid/constants.dart';
import 'package:nekodroid/widgets/single_line_text.dart';


class GenericRoute extends StatelessWidget {

	final String? title;
	final Widget? body;
	final void Function(BuildContext context)? onExitTap;
	
	const GenericRoute({
		super.key,
		this.title,
		this.body,
		this.onExitTap,
	});

	@override
	Widget build(BuildContext context) => SafeArea(
		child: Scaffold(
			resizeToAvoidBottomInset: false,
			floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
			floatingActionButton: SizedBox(
				height: kFabSize,
				width: kFabSize,
				child: FittedBox(
					child: FloatingActionButton(
						child: const Icon(Boxicons.bx_x),
						onPressed: () => onExitTap == null
							? Navigator.of(context).pop()
							: onExitTap?.call(context),
					),
				),
			),
			extendBodyBehindAppBar: true,
			appBar: title != null
				? PreferredSize(
					preferredSize: const Size.fromHeight(kTopBarHeight + kPaddingSecond),
					child: Card(
							margin: const EdgeInsets.only(
								top: kPaddingSecond,
								left: kPaddingSecond,
								right: kPaddingSecond,
							),
							child: Center(
								child: SingleLineText(
									title ?? "",
									style: Theme.of(context).textTheme.titleMedium,
								),
							),
						),
				)
				: null,
			body: body,
		),
	);
}
