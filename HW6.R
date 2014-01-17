#HW6

#QUESITON 1
#1.1
grep("[[:alpha:]]@[[:alpha:]]", x)
#x is a vector name I inserted as a space holder 
#1.2
grep("[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}", y)
#y is a vector name I inserted as a space holder 
#1.3
grep("^\\w+@{1}\\w+\\.{1}\\w+",z)
#z is a vector name I inserted as a space holder 

#QUESTION 2 
movies <-c("The Shawshank Redemption (1994)", "The Godfather (1972)", "The Godfather: Part II (1974)", "Pulp Fiction (1994)", "The Good, the Bad and the Ugly (1966)", "12 Angry Men (1957)")
grep("I{2,}", movies) 
#[1] 3
#"The Godfather: Part II (1974)"
grep("Go+d", movies) 
#[1] 2 3 5
#"The Godfather (1972)", "The Godfather: Part II (1974)", "The Good, the Bad and the Ugly (1966)"
gregexpr("\\(.*\\)", movies[1]) 
#[[1]]
#[1] 26
#attr(,"match.length")
#[1] 6
#attr(,"useBytes")
#[1] TRUE
gsub("[0-9]", "", movies[6]) 
#[1] "Angry Men ()"
gsub("[[:blank:]].*$", "", movies[5]) 
#[1] "The"
gsub(" \\(.*$", "", movies[5])
#[1] "The Good, the Bad and the Ugly"

#QUESTION 3
gregexpr("[0-9]{3,4}",  "stat133")
#[[1]]
#[1] 5
#attr(,"match.length")
#[1] 3
#attr(,"useBytes")
#[1] TRUE
gregexpr("[!,]",  "stat133")
#[[1]]
#[1] -1
#attr(,"match.length")
#[1] -1
#attr(,"useBytes")
#[1] TRUE
gregexpr("st",  "stat133")
#[[1]]
#[1] 1
#attr(,"match.length")
#[1] 2
#attr(,"useBytes")
#[1] TRUE
gregexpr("[A-Z]+",  "stat133")
#[[1]]
#[1] -1
#attr(,"match.length")
#[1] -1
#attr(,"useBytes")
#[1] TRUE
gregexpr("stat*",  "stat133")
#[[1]]
#[1] 1
#attr(,"match.length")
#[1] 4
#attr(,"useBytes")
#[1] TRUE

gregexpr("[0-9]{3,4}",  "statistics")
#[[1]]
#[1] -1
#attr(,"match.length")
#[1] -1
#attr(,"useBytes")
#[1] TRUE
gregexpr("[!,]",  "statistics")
#[[1]]
#[1] -1
#attr(,"match.length")
#[1] -1
#attr(,"useBytes")
#[1] TRUE
gregexpr("st",  "statistics")
#[[1]]
#[1] 1 6
#attr(,"match.length")
#[1] 2 2
#attr(,"useBytes")
#[1] TRUE
gregexpr("[A-Z]+",  "statistics")
#[[1]]
#[1] -1
#attr(,"match.length")
#[1] -1
#attr(,"useBytes")
#[1] TRUE
gregexpr("stat*",  "statistics")
#[[1]]
#[1] 1
#attr(,"match.length")
#[1] 4
#attr(,"useBytes")
#[1] TRUE

gregexpr("[0-9]{3,4}",  "I love R!")
#[[1]]
#[1] -1
#attr(,"match.length")
#[1] -1
#attr(,"useBytes")
#[1] TRUE
gregexpr("[!,]",  "I love R!")
#[[1]]
#[1] 9
#attr(,"match.length")
#[1] 1
#attr(,"useBytes")
#[1] TRUE
gregexpr("st",  "I love R!")
#[[1]]
#[1] -1
#attr(,"match.length")
#[1] -1
#attr(,"useBytes")
#[1] TRUE
gregexpr("[A-Z]+",  "I love R!")
#[[1]]
#[1] 1 8
#attr(,"match.length")
#[1] 1 1
#attr(,"useBytes")
#[1] TRUE
gregexpr("stat*",  "I love R!")
#[[1]]
#[1] -1
#attr(,"match.length")
#[1] -1
#attr(,"useBytes")
#[1] TRUE

gregexpr("[0-9]{3,4}",  "May 9, 1945")
#[[1]]
#[1] 8
#attr(,"match.length")
#[1] 4
#attr(,"useBytes")
#[1] TRUE
gregexpr("[!,]",  "May 9, 1945")
#[[1]]
#[1] 6
#attr(,"match.length")
#[1] 1
#attr(,"useBytes")
#[1] TRUE
gregexpr("st",  "May 9, 1945")
#[[1]]
#[1] -1
#attr(,"match.length")
#[1] -1
#attr(,"useBytes")
#[1] TRUE
gregexpr("[A-Z]+",  "May 9, 1945")
#[[1]]
#[1] 1
#attr(,"match.length")
#[1] 1
#attr(,"useBytes")
#[1] TRUE
gregexpr("stat*",  "May 9, 1945")
#[[1]]
#[1] -1
#attr(,"match.length")
#[1] -1
#attr(,"useBytes")
#[1] TRUE

