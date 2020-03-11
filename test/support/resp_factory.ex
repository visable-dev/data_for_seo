# defmodule RespFactory do
#   def basic_test_response do
#     ok(
#       %{data: "ok"},
#       %{"Content-Type" => "application/json"}
#     )
#   end

#   def bad_response do
#     ok(%{
#       "error" => %{
#         "code" => 400,
#         "message" => "this task id is used by another client, check the task id"
#       },
#       "results" => [],
#       "results_count" => 0,
#       "results_time" => "0.0437 sec.",
#       "status" => "error"
#     })
#   end

#   def create_tasks_response do
#     ok(
#       %{
#         "results" => %{
#           "Schrauben" => %{
#             "key_id" => 212_348_146,
#             "loc_id" => 2276,
#             "post_id" => "Schrauben",
#             "post_key" => "Schrauben",
#             "se_id" => 25,
#             "status" => "ok",
#             "task_id" => 12_620_846_274
#           }
#         },
#         "results_count" => 1,
#         "results_time" => "0.0688 sec.",
#         "status" => "ok"
#       },
#       %{"Content-Type" => "application/json"}
#     )
#   end

#   def completed_tasks_response do
#     ok(
#       %{
#         "results" => [
#           %{
#             "key_id" => 212_348_146,
#             "loc_id" => 2276,
#             "post_id" => "Schrauben",
#             "post_key" => "Schrauben",
#             "result_extra" => "people_also_ask,images,top_stories,local_pack",
#             "result_se_check_url" =>
#               "https://www.google.de/search?q=Schrauben&num=100&hl=de&gl=DE&gws_rd=cr&ie=UTF-8&oe=UTF-8&uule=w+CAIQIFISCWu-scIecppHEVvlkY5rXeh1",
#             "result_spell" => "",
#             "result_spell_type" => "",
#             "results_count" => 58_200_000,
#             "se_id" => 25,
#             "task_id" => 12_620_846_274
#           }
#         ],
#         "results_count" => 1,
#         "results_time" => "0.0666 sec.",
#         "status" => "ok"
#       },
#       %{"Content-Type" => "application/json"}
#     )
#   end

#   def task_result_response do
#     ok(
#       %{
#         "results" => %{
#           "extra" => %{
#             "related" => [
#               [
#                 "schrauben shop kleinmengen",
#                 "schrauben spax",
#                 "schrauben versandkostenfrei",
#                 "schrauben holz",
#                 "schrauben maße",
#                 "schrauben bezeichnung",
#                 "torx schrauben",
#                 "schrauben amazon"
#               ]
#             ]
#           },
#           "organic" => [
#             %{
#               "key_id" => 212_348_146,
#               "loc_id" => 2276,
#               "post_id" => "Schrauben",
#               "post_key" => "Schrauben",
#               "result_breadcrumb" => "https://online-schrauben.de › shop",
#               "result_datetime" => "2019-11-19 10:10:52 +00:00",
#               "result_extra" => "people_also_ask,images,top_stories,local_pack",
#               "result_highlighted" => ["Schrauben"],
#               "result_position" => 1,
#               "result_se_check_url" =>
#                 "https://www.google.de/search?q=Schrauben&num=100&hl=de&gl=DE&gws_rd=cr&ie=UTF-8&oe=UTF-8&uule=w+CAIQIFISCWu-scIecppHEVvlkY5rXeh1",
#               "result_snippet" =>
#                 "Schrauben online kaufen ✓ Großes Sortiment ✓ Faire Preise ✓ Schnelle Lieferung ✓ Beratung von Experten ✓ Über 25 Jahre.",
#               "result_snippet_extra" => "",
#               "result_spell" => "",
#               "result_spell_type" => "",
#               "result_stat" => [],
#               "result_title" => "Online Schrauben",
#               "result_url" => "https://online-schrauben.de/shop/",
#               "results_count" => 58_200_000,
#               "se_id" => 25,
#               "task_id" => 12_620_846_274
#             },
#             %{
#               "key_id" => 212_348_146,
#               "loc_id" => 2276,
#               "post_id" => "Schrauben",
#               "post_key" => "Schrauben",
#               "result_breadcrumb" => "https://de.wikipedia.org › wiki › Schraube",
#               "result_datetime" => "2019-11-19 10:10:52 +00:00",
#               "result_extra" => "people_also_ask,images,top_stories,local_pack",
#               "result_highlighted" => ["Schraube"],
#               "result_position" => 2,
#               "result_se_check_url" =>
#                 "https://www.google.de/search?q=Schrauben&num=100&hl=de&gl=DE&gws_rd=cr&ie=UTF-8&oe=UTF-8&uule=w+CAIQIFISCWu-scIecppHEVvlkY5rXeh1",
#               "result_snippet" =>
#                 "Eine Schraube ist ein zylindrischer oder leicht kegeliger (konischer) Körper, in dessen Oberfläche ein Gewinde eingeschnitten oder -gewalzt ist. An einem ihrer ...",
#               "result_snippet_extra" => "",
#               "result_spell" => "",
#               "result_spell_type" => "",
#               "result_stat" => [],
#               "result_title" => "Schraube – Wikipedia",
#               "result_url" => "https://de.wikipedia.org/wiki/Schraube",
#               "results_count" => 58_200_000,
#               "se_id" => 25,
#               "task_id" => 12_620_846_274
#             }
#           ],
#           "paid" => []
#         },
#         "results_count" => 98,
#         "results_time" => "0.0880 sec.",
#         "status" => "ok"
#       },
#       %{"Content-Type" => "application/json"}
#     )
#   end
# end
