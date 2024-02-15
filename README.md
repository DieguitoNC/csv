# Para executar e teste
no CMD colocar: iex -S mix   -> Csv.parse("test/fixtures/nome do arquivo para teste")
Para executar o teste: mix test

# O que foi utilizado e minha experiência
O código inteiro foi construído utilizando apenas a o elixir, sem nenhuma bliblioteca adicional. A parte mais geral do elixir eu consegui aprender por um curso da Udemy de Elixir e utilizei muito a documentação do próprio elixir, stack over flow, elixir forum alguns sites ou artigos sobre alguns assuntos que havia empacado e por último em casos extremos pedia alguma ajuda no gpt pra minha lógica funcionar.


# Lógica desenvolvida
Primeiro de tudo defini a função Parse e coloquei que ela deveria ler o documento e uma outra funcão que seria onde todo o tratamento dos dados que iria acontecer que foi a "handle_file_read". A primeiro momento pensei que deveria separar em linhas e colunas e depois por ",". Depois disso precisava pensar em um modo de converter tudo isso para um mapa o que eu demorei muito pra achar uma solução, depois disso surgiu o problema que o documento estava com o cabeçalho duplicado e removi a primeira linha dele antes da execução de transformar os dados em mapas. Depois de conseguir finalmente transformar tudo, precisei tratar os erros para cada tipo diferente, considero o segundo momento de maior dificuldade, visto que algumas vezes eu fazia e retornava algo "binario" e o código não rodava, a primeiro momento pensei em identificar se o documento existia ou não e executei na função parse. O segundo foi identificar se o resultado me retornava um arquivo vazio e coloquei ele depois da execução de todo o código. Por último tratei se o arquivo CSV tinha um modelo diferente. Descrevo os detalhes mais adiante de cada etapa.

# handle_file_read
Primeiro de tudo, queria deixar essa função extritamente para todo os tratamentos de dados e separar da função que cuida de ler o arquivo. Busquei quebrar em linhas com String.split "\r\n" e depois novamente String.split com ",". Depois dentro dela executei a função que converte esse CSV em Map com a função "Convert_to_map" e por último uma função que retira a primeira linha do csv: "remove_first_row" para que não ficasse com um mapa com as mesmas informações que as chaves se repetindo, porem executada antes do útlimo comando.

# convert_to_map
Depois disso pensei em usar uma função com chunck, mas não deu muito certo, porque pegava o primeiro elemento de cada lista e não a primeira lista, tentei utilizar a divisão [head | tail] para separar a primeira linha do restante mas nao deu muito certo. Depois de muito tempo achei a função Enum.zip que iria fazer justamente o que eu queria de um modo diferente. Então eu peguei e copiei a primeira linha do documento e criei a variável "headers". Depois separei em [header | row] no qual houve o problema da duplicação da primeira linha ser igual ao header e assim deveria deletar minha primneira linha.

# remove_first_row
Eu usei o mesmo metodo para converter para mapa, porém eu queria que retornasse apenas a parte que não tivesse a primeira linha, no começo fiz [a | body], porém eu deveria usar a variável "a" nesse caso, mas eu não queria, foi um dos momentos que usei o gpt para me ajudar e ele me lembrou que quando eu não vou usar necessariamente uma parte posso colocar "_" com isso consegui retornar apenas body e executar.


## Como filtrei os diferentes erros

# Documentos extras
criei 2 documentos cities2 e cities3 para checar se eles devolvem os problemas relatados corretamentes

# file_exist
Aqui eu tinha feito de um modo que estava me retornando modo binario e depois de muito tempo vi que poderia usar case para funcionar corretamente e se o resultado fosse true ele retornaria o proprio documento e seguiria o código, caso desse negattivo exibiria a msg que o arquivo não foi encontrado

# file_empty
Depois que vi que poderia usar case eu basicamente dupliquei a função file_exist e se o resultado fosse diferente de uma lista vazia ele continuava o código, caso contrário iria constar que o documento estava vazio

# case convert_to_map - invalid csv
Aqui basicamente eu segui o mesmo ideal e o principal problema foi identificar como eu começaria o case, depois de muito tempo vi que poderia comparar o tamanho com lenght e caso o tamanho da coluna fosse igual ao tamanho do meu cabeçalho ele aceitaria e continuaria o código. O problema que ele coloca a mensagem na mesma quantidade de linhas do csv o que pode gerar um problema no futuro


