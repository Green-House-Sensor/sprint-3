var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idEstufa", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idEstufa", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

router.get("/medidaskpi/:idEstufa", function (req, res) {
    medidaController.medidaskpi(req, res);
})
module.exports = router;