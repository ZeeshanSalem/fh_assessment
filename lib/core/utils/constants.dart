class Constant {
  static String kAccessTokenPref = "access-token"; // used in authentication.
  static String kBeneficiaries = "beneficiaries";
  static String kProfile = "myProfile";
  static int maxAllowBeneficiaries = 5;
  static int transactionFee = 3;
  static double monthlyTopUpLimit = 3000.0;
  static double verifiedBeneficiaryLimit = 1000.0;
  static double unVerifiedBeneficiaryLimit = 500.0;
  static String currency = 'AED';
  static String transactionSuccessMsg = 'TopUp Successfully Done';
  static String transactionUnSuccessMsg = 'TopUp UnSuccessfully';
  static List<num> rechargeableAmounts = [5, 10, 20, 30, 50, 75, 100];


}
