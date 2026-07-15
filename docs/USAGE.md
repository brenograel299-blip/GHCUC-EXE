# GHCUC EXE - Guia de Uso

## 🚀 Como Usar

### 1. Carregar o Executor
```lua
-- Execute this in your Roblox script executor
require(game:GetService("CoreGui"):WaitForChild("GHCUC_EXE").MainFrame)
```

### 2. Interface Básica
- **Script Input**: Caixa de texto para digitar seus scripts Lua
- **Execute Button**: Executa o script digitado
- **Clear Button**: Limpa a caixa de entrada
- **Console**: Mostra o histórico de execução

### 3. Exemplos de Scripts

#### Obter informações do jogador
```lua
local player = game:GetService("Players").LocalPlayer
print("Nome: " .. player.Name)
print("ID: " .. player.UserId)
```

#### Modificar saúde
```lua
local humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
if humanoid then
    humanoid.Health = 100
end
```

#### Teleportar
```lua
local newPos = Vector3.new(100, 50, 100)
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(newPos)
```

#### Listar jogadores
```lua
for _, player in pairs(game:GetService("Players"):GetPlayers()) do
    print(player.Name)
end
```

## 📚 Biblioteca Integrada

### Library.getPlayer(name)
Retorna um jogador pelo nome, ou o jogador local se sem parâmetros

### Library.getCharacter(player)
Retorna o personagem de um jogador

### Library.getHumanoid(character)
Retorna o humanoid de um personagem

### Library.teleport(position)
Teleporta o jogador para uma posição específica

### Library.getAllPlayers()
Retorna lista de todos os jogadores no jogo

### Library.removeCharacter()
Remove o personagem do jogador

## ⚠️ Segurança

- Sempre verifique se os scripts são seguros antes de executar
- Não compartilhe scripts de fontes desconhecidas
- Respeite os termos de serviço do Roblox

## 🐛 Troubleshooting

**Console não mostra mensagens?**
- Verifique se o script tem erros de sintaxe
- Veja o output do F9 para mais detalhes

**Script não executa?**
- Confirme que está no jogo (não no menu)
- Verifique a sintaxe Lua

**Funções não funcionam?**
- Certifique-se de que o game foi carregado completamente
- Teste no modo de um jogador primeiro

---

Divirta-se com GHCUC EXE! 🎮⚡