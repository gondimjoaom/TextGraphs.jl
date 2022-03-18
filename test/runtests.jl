using TextGraphs
using Test
using Graphs , MetaGraphs

@testset "TextGraphs.jl" begin
    english_sentence = "Colorless green ideas sleep furiously"
    pt_sentence = "No meio do caminho tinha uma pedra tinha uma pedra no meio do caminho"
    pt_double_sentence = "Aqui, temos duas frases separadas por pontuação. Essa é a frase de número dois."

    naive_g = TextGraphs.naive_graph(english_sentence)
    stem_g = TextGraphs.stem_graph(pt_sentence;snowball_language="portuguese")
    phrases_g = TextGraphs.phrases_graph(pt_double_sentence)

    @test (nv(naive_g),ne(naive_g)) == (5,4)
    @test (nv(stem_g),ne(stem_g)) == (8,9)
    @test (nv(phrases_g),ne(phrases_g)) == (2,1)

    naive_g_labels = map(x -> get_prop(naive_g,x,:token), collect(1:nv(naive_g)))
    stem_g_labels = map(x -> get_prop(stem_g,x,:token), collect(1:nv(stem_g)))

    @test naive_g_labels[4:5] == ["sleep","furiously"]
    @test (stem_g_labels[4] , stem_g_labels[5]) == ("caminh","tinh") 

end