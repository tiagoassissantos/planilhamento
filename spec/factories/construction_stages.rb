FactoryBot.define do
  factory :construction_stage, class: ConstructionStage do
    name {'Etapa 1'}
    quantity {0}
    pavement {1}
    construction {create(:construction)}
  end
end
