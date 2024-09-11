abstract class UserTransactionInterface {
  const UserTransactionInterface();
}

class SuccessWithdrawResult extends UserTransactionInterface {
  final num decreasedBalance;

  const SuccessWithdrawResult(this.decreasedBalance);
}

class InsufficientBalanceWithdrawResult extends UserTransactionInterface {
  final num currentBalance;

  const InsufficientBalanceWithdrawResult(this.currentBalance);
}

class SuccessDepositResult extends UserTransactionInterface {
  final num currentBalance;

  const SuccessDepositResult(this.currentBalance);
}

class UnsuccessfulTransactionResult extends UserTransactionInterface {
  const UnsuccessfulTransactionResult();
}
