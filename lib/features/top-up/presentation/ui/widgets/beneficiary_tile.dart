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
              child:
                  Text('${beneficiary.nickName?.substring(0).toUpperCase()}'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 02,
            children: [
              Text(
                'Zeeshan Saleem',
                style: AppTypography.lightTheme.bodyMedium,
              ),
              Text(
                '+971-524691686',
                style: AppTypography.lightTheme.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
