part of 'beneficiaries_tile.dart';

class BeneficiaryTile extends StatelessWidget {
  const BeneficiaryTile({
    super.key,
    this.isSelected = false,
    required this.beneficiary,
  });

  final bool isSelected;
  final Beneficiary beneficiary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: CircleAvatar(
              child: Text(
                  '${beneficiary.nickName?.substring(0, 1).toUpperCase()}'),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 02,
              children: [
                Text(
                  '${beneficiary.nickName}',
                  style: AppTypography.lightTheme.bodyMedium,
                ),
                Text(
                  '${beneficiary.id}',
                  style: AppTypography.lightTheme.titleSmall,
                ),
              ],
            ),
          ),
          if (isSelected)
            Icon(
              Icons.check,
              size: 24,
              color: CustomColors.success,
            ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'edit') {
                showDialog(
                  context: context,
                  builder: (dialogContext) => BlocProvider.value(
                    value: context.read<BeneficiaryCubit>(),
                    child: AddBeneficiaryDialog(
                      beneficiary: beneficiary,
                    ),
                  ),
                );
              } else if (value == 'delete') {
                showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return ConfirmationDialog(
                        actionButtonName: 'Delete',
                        btnColor: CustomColors.error,

                        // showConfirmButton: false,
                      );
                    }).then((value) {
                  if (value == true) {
                    _onDelete(context);
                  }
                });
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Text(
                    'Edit',
                    style: AppTypography.lightTheme.bodyMedium,
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Text(
                    'Delete',
                    style: AppTypography.lightTheme.bodyMedium?.copyWith(
                      color: CustomColors.error,
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }

  _onDelete(BuildContext context) {
    if (context.read<TopUpCubit>().state.selectedBeneficiary?.id ==
        beneficiary.id) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          status: SnackBarStatusEnum.warning,
          context: context,
          msg: 'You Cannot delete selected Beneficiary',
        ),
      );
      return;
    }

    context.read<BeneficiaryCubit>().deleteBeneficiary('${beneficiary.id}');
  }
}
