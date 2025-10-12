# ~/nixos-config/flake.nix
{
  description = "Minha configuração pessoal do NixOS";

  # Entradas (dependências) do seu sistema
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Você pode usar 'nixos-24.05' para a versão estável

    # Home Manager é ótimo para gerenciar dotfiles e pacotes de usuário
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # Garante que o home-manager use a mesma versão do nixpkgs
    };
  };

  # Saídas (o que este Flake produz)
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    # A configuração do seu sistema NixOS
    nixosConfigurations = {
      alvaro = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # ou "aarch64-linux" para ARM
        specialArgs = { inherit inputs; }; # Permite acessar as entradas nos outros arquivos
        modules = [
          # Importa sua configuração principal
          ./configuration.nix

          # Adiciona o módulo do Home Manager ao sistema
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
