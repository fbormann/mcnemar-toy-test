require(dplyr)

team_name <- c("Naútico", "Naútico", "Naútico", "Naútico", "Naútico", "Naútico")
username <- c("Felipe", "Mazinho", "Larissa", "Raissa", "Lucas", "Carla")

my_team_is_great <- c("Sim", "Sim", "Sim", "Não", "Sim", "Sim")

first_df <- data.frame(team_name=team_name, username=username, my_team_is_great=my_team_is_great)


team_name <- c("Naútico", "Naútico", "Naútico", "Naútico", "Naútico", "Naútico")
username <- c("Felipe", "Mazinho", "Larissa", "Raissa", "Lucas", "Carla")

my_team_is_great <- c("Sim", "Não", "Não", "Não", "Não", "Não")

second_df <- data.frame(team_name=team_name, username=username, my_team_is_great=my_team_is_great)

# aqui a gente consegue criar o dataset que pode gerar a tabela de contigência para o teste de mcnemar's
final_df <- merge(first_df, second_df, by="username")


# teste sobre a dicotômia das classes
length(unique(final_df$my_team_is_great.x)) == 2
length(unique(final_df$my_team_is_great.y)) == 2

# teste sobre a paridade dos dados usados para a tabela de contigência
(length(final_df$username) == length(first_df$username)) && (length(final_df$username) == length(second_df$username))

# O próximo passo é gerar os vetores de entrada do teste
those_which_are_equal <- final_df[(final_df$my_team_is_great.x == final_df$my_team_is_great.y), c("username", "my_team_is_great.x")]
those_which_are_not_equal <- final_df[(final_df$my_team_is_great.x != final_df$my_team_is_great.y), c("username", "my_team_is_great.x")]

equal_grouped <- aggregate(those_which_are_equal$my_team_is_great.x, by=list(those_which_are_equal$my_team_is_great.x), FUN=length)
not_equal_grouped <- aggregate(those_which_are_not_equal$my_team_is_great.x, by=list(those_which_are_not_equal$my_team_is_great.x), FUN=length)

# eu não consegui gerar o dataset de entrada da tabela de contigência via código mas como são poucos dados, foi fácil fazer na mão.


Performance <-
  matrix(c(5, 1, 1, 5),
         nrow = 2,
         dimnames = list("1st Survey" = c("My Team Is Great", "My Team Is Not Great"),
                         "2nd Survey" = c("My Team Is Great", "My Team Is Not Great")))
Performance
mcnemar.test(Performance, correct=FALSE)
