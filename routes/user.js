const path = require('path');
const express = require('express');
const pageController = require('../controllers/pages');

const router = express.Router();

router.get('/',pageController.getp1);

router.post('/p1', pageController.postp1_data);
//router.post('/p1', pageController.postp1_todblp);

router.get('/p2_add_tags',pageController.getp2);
router.post('/p2_general_post', pageController.post_generalTags);
router.post('/start_general_scrape',pageController.p2_start_general);

router.post('/p2_dblp_post',pageController.p2PostTags);
router.post('/start_dblp_scrape',pageController.p2_start_dblp);
router.get('/p2_dataselection_dblp',pageController.getp2dblp);

router.get('/p3_result_dblp',pageController.getp3dblp);
router.post('/downloadjson',pageController.p3_downloadJsonFile);
router.get('/p3_general_result',pageController.getp3general);
router.post('/downloadjson_general',pageController.p3_downloadJsonFile_general);

router.get('/p4_load_dblp',pageController.getp4_load_dblp);
router.post('/p4_load_dblp',pageController.postp3_p4_dblp);
router.get('/p4_general_load',pageController.p4_general_load);
router.post('/p4_general_post',pageController.p4_post_general_load);
router.post('/load_dblp_sql',pageController.p4_post_dblp_load);

router.post('/create_table_general',pageController.p4_create_general_input);
router.post('/execute_general_table',pageController.p4_load_general_table);


router.get('/transformations_dblp',pageController.getp5_transformation_dblp);
router.post('/transformation1',pageController.p5_post_trans1);
router.post('/transformation2',pageController.p5_post_trans2);
router.post('/query_dblp',pageController.p5_post_query);
router.post('/personal_query',pageController.p5_personal_Query);
router.post('/execute_personal_query',pageController.p5_exe_personal_query);


module.exports = router;