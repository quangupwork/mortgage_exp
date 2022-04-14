class CaculatorHelper {
  static int getDependant(int dependants, bool isSingle) {
    int annualExpence = 0;
    switch (dependants) {
      case 0:
        {
          if (isSingle) {
            annualExpence = 16460;
          } else {
            annualExpence = 23930;
          }
        }
        break;
      case 1:
        {
          if (isSingle) {
            annualExpence = 22607;
          } else {
            annualExpence = 29746;
          }
        }
        break;
      case 2:
        {
          if (isSingle) {
            annualExpence = 28423;
          } else {
            annualExpence = 35562;
          }
        }
        break;
      case 3:
        {
          if (isSingle) {
            annualExpence = 34239;
          } else {
            annualExpence = 41379;
          }
        }
        break;
      case 4:
        {
          if (isSingle) {
            annualExpence = 40056;
          } else {
            annualExpence = 47130;
          }
        }
        break;
      default:
        annualExpence = 11400;
        break;
    }
    return annualExpence;
  }
}
