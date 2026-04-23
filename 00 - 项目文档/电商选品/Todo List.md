---

---
--- 
- [ ] 首页Forum Engine的左侧，Agent名称还是旧的没改
- [ ] Supply Agent、Product Agent处理速度很慢，控制台有偶然的报错出现

```SupplyAgent
[16:12:38] 2026-04-23 16:12:38.792 | INFO | InsightEngine.agent:execute_search_tool:272 - 🔍 原始查询: 'custom t-shirt POD'

[16:12:38] 2026-04-23 16:12:38.792 | INFO | InsightEngine.agent:execute_search_tool:273 - ✨ 优化后关键词: ['定制T恤', '个性化T恤', 'DIY T恤', '一件代发', '无货源开店', '原创设计T恤', 'T恤定制靠谱吗', '定制T恤避雷', '副业做T恤', '定制T恤质量', '定制T恤赚钱吗', '定制T恤坑', '创意T恤', '小众T恤', '印图定制']

[16:12:38] 2026-04-23 16:12:38.795 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: '定制T恤'

[16:12:38] 2026-04-23 16:12:38.795 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'定制T恤'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.795 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: '个性化T恤'

[16:12:38] 2026-04-23 16:12:38.795 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'个性化T恤'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.795 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: 'DIY T恤'

[16:12:38] 2026-04-23 16:12:38.795 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'DIY T恤'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.795 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: '一件代发'

[16:12:38] 2026-04-23 16:12:38.795 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'一件代发'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.795 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: '无货源开店'

[16:12:38] 2026-04-23 16:12:38.795 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'无货源开店'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.795 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: '原创设计T恤'

[16:12:38] 2026-04-23 16:12:38.795 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'原创设计T恤'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.795 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: 'T恤定制靠谱吗'

[16:12:38] 2026-04-23 16:12:38.795 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'T恤定制靠谱吗'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.795 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: '定制T恤避雷'

[16:12:38] 2026-04-23 16:12:38.795 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'定制T恤避雷'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.795 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: '副业做T恤'

[16:12:38] 2026-04-23 16:12:38.795 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'副业做T恤'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.795 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: '定制T恤质量'

[16:12:38] 2026-04-23 16:12:38.795 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'定制T恤质量'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.795 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: '定制T恤赚钱吗'

[16:12:38] 2026-04-23 16:12:38.795 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'定制T恤赚钱吗'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.795 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: '定制T恤坑'

[16:12:38] 2026-04-23 16:12:38.795 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'定制T恤坑'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.795 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: '创意T恤'

[16:12:38] 2026-04-23 16:12:38.795 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'创意T恤'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.795 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: '小众T恤'

[16:12:38] 2026-04-23 16:12:38.808 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'小众T恤'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.809 | INFO | InsightEngine.agent:execute_search_tool:280 - 查询关键词: '印图定制'

[16:12:38] 2026-04-23 16:12:38.810 | ERROR | InsightEngine.agent:execute_search_tool:351 - 查询'印图定制'时出错: 'SupplyChainDB' object has no attribute 'search_topic_globally'

[16:12:38] 2026-04-23 16:12:38.810 | INFO | InsightEngine.agent:execute_search_tool:356 - 总计找到 0 条结果，去重后 0 条

[16:12:38] 2026-04-23 16:12:38.810 | INFO | InsightEngine.agent:_initial_search_and_summary:732 - - 未找到搜索结果

[16:12:38] 2026-04-23 16:12:38.810 | INFO | InsightEngine.agent:_initial_search_and_summary:738 - - 生成初始总结...

[16:12:38] 2026-04-23 16:12:38.810 | DEBUG | utils.forum_reader:get_latest_host_speech:45 - 未找到HOST发言

[16:12:38] 2026-04-23 16:12:38.810 | INFO | InsightEngine.nodes.summary_node:run:100 - 正在生成首次段落总结
```

```ProfitAgent
[16:16:45] Accessing `__path__` from `.models.aria.image_processing_aria`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.378 Examining the path of transformers.models.aria.image_processing_aria_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.aria.image_processing_pil_aria`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.auto.image_processing_auto`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.beit.image_processing_beit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.390 Examining the path of transformers.models.beit.image_processing_beit_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.beit.image_processing_pil_beit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.bit.image_processing_bit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.bit.image_processing_pil_bit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.blip.image_processing_blip`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.blip.image_processing_pil_blip`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.bridgetower.image_processing_bridgetower`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.449 Examining the path of transformers.models.bridgetower.image_processing_bridgetower_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.bridgetower.image_processing_pil_bridgetower`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.chameleon.image_processing_chameleon`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.457 Examining the path of transformers.models.chameleon.image_processing_chameleon_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.chameleon.image_processing_pil_chameleon`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.chinese_clip.image_processing_chinese_clip`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.chinese_clip.image_processing_chinese_pil_clip`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.chmv2.image_processing_chmv2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.486 Examining the path of transformers.models.chmv2.image_processing_chmv2_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.clip.image_processing_clip`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.clip.image_processing_pil_clip`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.cohere2_vision.image_processing_cohere2_vision`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.506 Examining the path of transformers.models.cohere2_vision.image_processing_cohere2_vision_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.conditional_detr.image_processing_conditional_detr`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.522 Examining the path of transformers.models.conditional_detr.image_processing_conditional_detr_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.conditional_detr.image_processing_pil_conditional_detr`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.convnext.image_processing_convnext`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.546 Examining the path of transformers.models.convnext.image_processing_convnext_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.convnext.image_processing_pil_convnext`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.deepseek_vl.image_processing_deepseek_vl`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.546 Examining the path of transformers.models.deepseek_vl.image_processing_deepseek_vl_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.deepseek_vl.image_processing_pil_deepseek_vl`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.deepseek_vl_hybrid.image_processing_deepseek_vl_hybrid`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.577 Examining the path of transformers.models.deepseek_vl_hybrid.image_processing_deepseek_vl_hybrid_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.deepseek_vl_hybrid.image_processing_pil_deepseek_vl_hybrid`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.deformable_detr.image_processing_deformable_detr`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.607 Examining the path of transformers.models.deformable_detr.image_processing_deformable_detr_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.deformable_detr.image_processing_pil_deformable_detr`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.deit.image_processing_deit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.deit.image_processing_pil_deit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.depth_pro.image_processing_depth_pro`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.641 Examining the path of transformers.models.depth_pro.image_processing_depth_pro_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.detr.image_processing_detr`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.650 Examining the path of transformers.models.detr.image_processing_detr_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.detr.image_processing_pil_detr`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.dinov3_vit.image_processing_dinov3_vit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.675 Examining the path of transformers.models.dinov3_vit.image_processing_dinov3_vit_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.donut.image_processing_donut`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.692 Examining the path of transformers.models.donut.image_processing_donut_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.donut.image_processing_pil_donut`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.dpt.image_processing_dpt`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.720 Examining the path of transformers.models.dpt.image_processing_dpt_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.dpt.image_processing_pil_dpt`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.efficientloftr.image_processing_efficientloftr`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.755 Examining the path of transformers.models.efficientloftr.image_processing_efficientloftr_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.efficientloftr.image_processing_pil_efficientloftr`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.efficientnet.image_processing_efficientnet`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.779 Examining the path of transformers.models.efficientnet.image_processing_efficientnet_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.efficientnet.image_processing_pil_efficientnet`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.emu3.image_processing_emu3`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.eomt.image_processing_eomt`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.807 Examining the path of transformers.models.eomt.image_processing_eomt_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.eomt.image_processing_pil_eomt`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.ernie4_5_vl_moe.image_processing_ernie4_5_vl_moe`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.833 Examining the path of transformers.models.ernie4_5_vl_moe.image_processing_ernie4_5_vl_moe_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.ernie4_5_vl_moe.image_processing_pil_ernie4_5_vl_moe`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.flava.image_processing_flava`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.866 Examining the path of transformers.models.flava.image_processing_flava_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.flava.image_processing_pil_flava`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.fuyu.image_processing_fuyu`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.907 Examining the path of transformers.models.fuyu.image_processing_fuyu_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.fuyu.image_processing_pil_fuyu`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.gemma3.image_processing_gemma3`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.924 Examining the path of transformers.models.gemma3.image_processing_gemma3_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.gemma3.image_processing_pil_gemma3`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.gemma4.image_processing_gemma4`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] 2026-04-23 16:16:45.962 Examining the path of transformers.models.gemma4.image_processing_gemma4_fast raised: No module named 'torchvision'

[16:16:45] Accessing `__path__` from `.models.gemma4.image_processing_pil_gemma4`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:45] Accessing `__path__` from `.models.glm46v.image_processing_glm46v`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.004 Examining the path of transformers.models.glm46v.image_processing_glm46v_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.glm46v.image_processing_pil_glm46v`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.glm4v.image_processing_glm4v`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.032 Examining the path of transformers.models.glm4v.image_processing_glm4v_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.glm4v.image_processing_pil_glm4v`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.glm_image.image_processing_glm_image`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.074 Examining the path of transformers.models.glm_image.image_processing_glm_image_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.glm_image.image_processing_pil_glm_image`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.glpn.image_processing_glpn`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.116 Examining the path of transformers.models.glpn.image_processing_glpn_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.glpn.image_processing_pil_glpn`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.got_ocr2.image_processing_got_ocr2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.140 Examining the path of transformers.models.got_ocr2.image_processing_got_ocr2_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.got_ocr2.image_processing_pil_got_ocr2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.grounding_dino.image_processing_grounding_dino`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.156 Examining the path of transformers.models.grounding_dino.image_processing_grounding_dino_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.grounding_dino.image_processing_pil_grounding_dino`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.idefics.image_processing_idefics`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.idefics.image_processing_pil_idefics`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.idefics2.image_processing_idefics2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.225 Examining the path of transformers.models.idefics2.image_processing_idefics2_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.idefics2.image_processing_pil_idefics2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.idefics3.image_processing_idefics3`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.260 Examining the path of transformers.models.idefics3.image_processing_idefics3_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.idefics3.image_processing_pil_idefics3`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.imagegpt.image_processing_imagegpt`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.284 Examining the path of transformers.models.imagegpt.image_processing_imagegpt_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.imagegpt.image_processing_pil_imagegpt`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.janus.image_processing_janus`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.300 Examining the path of transformers.models.janus.image_processing_janus_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.janus.image_processing_pil_janus`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.kosmos2_5.image_processing_kosmos2_5`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.kosmos2_5.image_processing_pil_kosmos2_5`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.layoutlmv2.image_processing_layoutlmv2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.372 Examining the path of transformers.models.layoutlmv2.image_processing_layoutlmv2_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.layoutlmv2.image_processing_pil_layoutlmv2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.layoutlmv3.image_processing_layoutlmv3`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.400 Examining the path of transformers.models.layoutlmv3.image_processing_layoutlmv3_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.layoutlmv3.image_processing_pil_layoutlmv3`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.levit.image_processing_levit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.425 Examining the path of transformers.models.levit.image_processing_levit_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.levit.image_processing_pil_levit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.lfm2_vl.image_processing_lfm2_vl`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.441 Examining the path of transformers.models.lfm2_vl.image_processing_lfm2_vl_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.lightglue.image_processing_lightglue`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.441 Examining the path of transformers.models.lightglue.image_processing_lightglue_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.lightglue.image_processing_pil_lightglue`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.llama4.image_processing_llama4`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.477 Examining the path of transformers.models.llama4.image_processing_llama4_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.llava.image_processing_llava`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.483 Examining the path of transformers.models.llava.image_processing_llava_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.llava.image_processing_pil_llava`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.llava_next.image_processing_llava_next`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.500 Examining the path of transformers.models.llava_next.image_processing_llava_next_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.llava_next.image_processing_pil_llava_next`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.llava_onevision.image_processing_llava_onevision`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.519 Examining the path of transformers.models.llava_onevision.image_processing_llava_onevision_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.llava_onevision.image_processing_pil_llava_onevision`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.mask2former.image_processing_mask2former`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.547 Examining the path of transformers.models.mask2former.image_processing_mask2former_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.mask2former.image_processing_pil_mask2former`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.maskformer.image_processing_maskformer`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.577 Examining the path of transformers.models.maskformer.image_processing_maskformer_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.maskformer.image_processing_pil_maskformer`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.mllama.image_processing_mllama`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.615 Examining the path of transformers.models.mllama.image_processing_mllama_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.mllama.image_processing_pil_mllama`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.mobilenet_v1.image_processing_mobilenet_pil_v1`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.mobilenet_v1.image_processing_mobilenet_v1`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.mobilenet_v2.image_processing_mobilenet_v2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.655 Examining the path of transformers.models.mobilenet_v2.image_processing_mobilenet_v2_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.mobilenet_v2.image_processing_pil_mobilenet_v2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.mobilevit.image_processing_mobilevit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.674 Examining the path of transformers.models.mobilevit.image_processing_mobilevit_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.mobilevit.image_processing_pil_mobilevit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.nougat.image_processing_nougat`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.695 Examining the path of transformers.models.nougat.image_processing_nougat_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.nougat.image_processing_pil_nougat`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.oneformer.image_processing_oneformer`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.722 Examining the path of transformers.models.oneformer.image_processing_oneformer_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.oneformer.image_processing_pil_oneformer`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.ovis2.image_processing_ovis2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.749 Examining the path of transformers.models.ovis2.image_processing_ovis2_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.ovis2.image_processing_pil_ovis2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.owlv2.image_processing_owlv2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.788 Examining the path of transformers.models.owlv2.image_processing_owlv2_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.owlv2.image_processing_pil_owlv2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.owlvit.image_processing_owlvit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.owlvit.image_processing_pil_owlvit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.paddleocr_vl.image_processing_paddleocr_vl`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.paddleocr_vl.image_processing_pil_paddleocr_vl`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.perceiver.image_processing_perceiver`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.839 Examining the path of transformers.models.perceiver.image_processing_perceiver_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.perceiver.image_processing_pil_perceiver`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.perception_lm.image_processing_perception_lm`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.851 Examining the path of transformers.models.perception_lm.image_processing_perception_lm_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.phi4_multimodal.image_processing_phi4_multimodal`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.858 Examining the path of transformers.models.phi4_multimodal.image_processing_phi4_multimodal_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.pi0.image_processing_pi0`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.pix2struct.image_processing_pil_pix2struct`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.pix2struct.image_processing_pix2struct`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.910 Examining the path of transformers.models.pix2struct.image_processing_pix2struct_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.pixtral.image_processing_pil_pixtral`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.pixtral.image_processing_pixtral`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.928 Examining the path of transformers.models.pixtral.image_processing_pixtral_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.poolformer.image_processing_pil_poolformer`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.poolformer.image_processing_poolformer`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.938 Examining the path of transformers.models.poolformer.image_processing_poolformer_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.pp_chart2table.image_processing_pil_pp_chart2table`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.pp_chart2table.image_processing_pp_chart2table`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] Accessing `__path__` from `.models.pp_doclayout_v2.image_processing_pp_doclayout_v2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.957 Examining the path of transformers.models.pp_doclayout_v2.image_processing_pp_doclayout_v2_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.pp_doclayout_v3.image_processing_pp_doclayout_v3`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.966 Examining the path of transformers.models.pp_doclayout_v3.image_processing_pp_doclayout_v3_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.pp_lcnet.image_processing_pp_lcnet`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.974 Examining the path of transformers.models.pp_lcnet.image_processing_pp_lcnet_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.pp_ocrv5_server_det.image_processing_pp_ocrv5_server_det`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.982 Examining the path of transformers.models.pp_ocrv5_server_det.image_processing_pp_ocrv5_server_det_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.pp_ocrv5_server_rec.image_processing_pp_ocrv5_server_rec`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:46] 2026-04-23 16:16:46.990 Examining the path of transformers.models.pp_ocrv5_server_rec.image_processing_pp_ocrv5_server_rec_fast raised: No module named 'torchvision'

[16:16:46] Accessing `__path__` from `.models.prompt_depth_anything.image_processing_pil_prompt_depth_anything`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.prompt_depth_anything.image_processing_prompt_depth_anything`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.007 Examining the path of transformers.models.prompt_depth_anything.image_processing_prompt_depth_anything_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.pvt.image_processing_pil_pvt`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.pvt.image_processing_pvt`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.qwen2_vl.image_processing_pil_qwen2_vl`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.qwen2_vl.image_processing_qwen2_vl`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.055 Examining the path of transformers.models.qwen2_vl.image_processing_qwen2_vl_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.rt_detr.image_processing_pil_rt_detr`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.rt_detr.image_processing_rt_detr`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.083 Examining the path of transformers.models.rt_detr.image_processing_rt_detr_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.sam.image_processing_pil_sam`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.sam.image_processing_sam`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.111 Examining the path of transformers.models.sam.image_processing_sam_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.sam2.image_processing_sam2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.119 Examining the path of transformers.models.sam2.image_processing_sam2_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.sam3.image_processing_sam3`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.133 Examining the path of transformers.models.sam3.image_processing_sam3_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.segformer.image_processing_pil_segformer`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.segformer.image_processing_segformer`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.149 Examining the path of transformers.models.segformer.image_processing_segformer_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.seggpt.image_processing_pil_seggpt`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.seggpt.image_processing_seggpt`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.167 Examining the path of transformers.models.seggpt.image_processing_seggpt_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.siglip.image_processing_pil_siglip`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.siglip.image_processing_siglip`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.siglip2.image_processing_pil_siglip2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.siglip2.image_processing_siglip2`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.199 Examining the path of transformers.models.siglip2.image_processing_siglip2_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.slanext.image_processing_slanext`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.207 Examining the path of transformers.models.slanext.image_processing_slanext_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.smolvlm.image_processing_pil_smolvlm`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.smolvlm.image_processing_smolvlm`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.226 Examining the path of transformers.models.smolvlm.image_processing_smolvlm_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.superglue.image_processing_pil_superglue`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.superglue.image_processing_superglue`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.241 Examining the path of transformers.models.superglue.image_processing_superglue_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.superpoint.image_processing_pil_superpoint`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.superpoint.image_processing_superpoint`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.253 Examining the path of transformers.models.superpoint.image_processing_superpoint_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.swin2sr.image_processing_pil_swin2sr`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.swin2sr.image_processing_swin2sr`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.275 Examining the path of transformers.models.swin2sr.image_processing_swin2sr_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.textnet.image_processing_pil_textnet`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.textnet.image_processing_textnet`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.294 Examining the path of transformers.models.textnet.image_processing_textnet_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.timm_wrapper.image_processing_timm_wrapper`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.tvp.image_processing_pil_tvp`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.tvp.image_processing_tvp`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.322 Examining the path of transformers.models.tvp.image_processing_tvp_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.uvdoc.image_processing_uvdoc`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.video_llama_3.image_processing_pil_video_llama_3`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.video_llama_3.image_processing_video_llama_3`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.video_llava.image_processing_video_llava`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.videomae.image_processing_pil_videomae`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.videomae.image_processing_videomae`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.380 Examining the path of transformers.models.videomae.image_processing_videomae_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.vilt.image_processing_pil_vilt`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.vilt.image_processing_vilt`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.390 Examining the path of transformers.models.vilt.image_processing_vilt_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.vit.image_processing_pil_vit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.vit.image_processing_vit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.vitmatte.image_processing_pil_vitmatte`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.vitmatte.image_processing_vitmatte`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.411 Examining the path of transformers.models.vitmatte.image_processing_vitmatte_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.vitpose.image_processing_pil_vitpose`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.vitpose.image_processing_vitpose`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.432 Examining the path of transformers.models.vitpose.image_processing_vitpose_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.vivit.image_processing_vivit`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.yolos.image_processing_pil_yolos`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.yolos.image_processing_yolos`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.463 Examining the path of transformers.models.yolos.image_processing_yolos_fast raised: No module named 'torchvision'

[16:16:47] Accessing `__path__` from `.models.zoedepth.image_processing_pil_zoedepth`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] Accessing `__path__` from `.models.zoedepth.image_processing_zoedepth`. Returning `__path__` instead. Behavior may be different and this alias will be removed in future versions.

[16:16:47] 2026-04-23 16:16:47.482 Examining the path of transformers.models.zoedepth.image_processing_zoedepth_fast raised: No module named 'torchvision'
```

