all@{ inputs, ... }:
{
  users.users.root.hashedPasswordFile = "${inputs.user-passwords}/root.secret";
}
