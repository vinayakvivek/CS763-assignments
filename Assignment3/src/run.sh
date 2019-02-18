# python3 checkModel.py \
#     -config ../info/modelConfig_2.txt \
#     -i ../info/input_sample_2.bin \
#     -og ../info/gradOutput_sample_2.bin \
#     -o outputs/output_sample_2.bin \
#     -ow outputs/gradW_sample_2.bin \
#     -ob outputs/gradB_sample_2.bin \
#     -ig outputs/gradInput_sample_2.bin

# python3 checkModel.py \
#     -config ../info/modelConfig_1.txt \
#     -i ../info/input_sample_1.bin \
#     -og ../info/gradOutput_sample_1.bin \
#     -o outputs/output_sample_1.bin \
#     -ow outputs/gradW_sample_1.bin \
#     -ob outputs/gradB_sample_1.bin \
#     -ig outputs/gradInput_sample_1.bin

# -----------------------------------
# checkCriterion

python3 checkCriterion.py \
    -i ../info/input_criterion_sample_1.bin \
    -t ../info/target_sample_1.bin \
    -ig outputs/gradCriterionInput_sample_1.bin

python3 checkCriterion.py \
    -i ../info/input_criterion_sample_2.bin \
    -t ../info/target_sample_2.bin \
    -ig outputs/gradCriterionInput_sample_2.bin
