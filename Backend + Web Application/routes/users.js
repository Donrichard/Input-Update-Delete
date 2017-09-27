var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/userlist', function(req, res) {
	var db = req.db;
	var collection = db.get('userlist');
	collection.find({},{},function(e,docs) {
		res.json({students: docs});
	});
});

router.post('/adduser', function(req,res) {
	// console.log(req.body);
	var db = req.db;
	var collection = db.get('userlist');
	collection.insert(req.body, function(err, res) {
		res.send((err === null) ? { msg : '' } : { msg:"Error: " + err });
	});
});

router.delete('/deleteuser/:id', function(req, res) {
	var db = req.db;
	var collection = db.get('userlist');
	var userToDelete = req.params.id;
	collection.remove({ '_id' : userToDelete }, function(err) {
		res.send((err === null) ? {msg : ''} : {msg:"Error: " + err});
	});
});

router.put('/updateuser/:id', function(req, res) {
	console.log(req.body);
	var db = req.db;
	var collection = db.get('userlist');
	var userToUpdate = req.params.id;
	collection.update({ '_id' : userToUpdate}, req.body, function(err, res) {
		res.send((err === null) ? {msg: ''} : {msg:"Error: " + err});
	});
});

module.exports = router;
