{ ... }:
{
  users.users.root.hashedPasswordFile = "${passwords/root.secret}";
}
