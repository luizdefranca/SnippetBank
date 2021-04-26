# SnippetBank

### Desafio 2: (Catálogo de Snippets) - 3 pontos

---

Requisitos:

1. Adicione uma forma de criar novos snippets usando um `UIBarButtonItem`. Ao dar tap no botão, um novo snippet é criado e adicionado na lista. Use `tableView.reloadData()` ao adicionar o novo snippet para atualizar a Table View; (1 ponto)

2. Adapte a aplicação para suportar tanto snippets de Swift quanto snippets de Python 3. Use o `Python3Lexer` do [Sourceful](https://github.com/twostraws/Sourceful) para fazer o Syntax Highlighting dos snippets de Python. Adicione um `UIBarButtonItem` na `DetailViewController` com um `UIMenu` contendo uma ação para cada linguagem. A pessoa pode escolher uma linguagem do menu para trocar a linguagem do snippet sendo editado; (1 ponto)
3. Adicione outra propriedade no `Snippet` que representa uma lista de Tags (ex: `"Networking"`, `"Persistência"`, ...). Mude o estilo do Split View no storyboard para *triple column* e faça com que a primeira coluna mostre a lista de tags. Crie uma novo view controller que herda de `UITableViewController` chamada de `SupplementaryViewController` que gerencia os snippets e suas tags. Modifique o método `scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)` do `SceneDelegate` para setar as propriedades e delegates corretamente. (1 ponto). Use o método `show` do `SplitViewController` para mostrar as colunas *supplementary* e *secondary*.

 <img src="snippet_Ipad.gif" alt="Um exemplo da tela" width="269" height="377">
 <img src="snippet_iPhone.gif" alt="Um exemplo da tela" width="219" height="472">
