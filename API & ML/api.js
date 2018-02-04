var express = require('express');
var fs = require('fs');
var mongodb = require('mongodb');
var bodyParser = require('body-parser');
var shortid = require('shortid');
var exec = require('child_process').exec;

var app = express();
var MongoClient = mongodb.MongoClient;

app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());

app.set('view engine','ejs');

var url = "mongodb://localhost:27017/net_data";

// api gets

app.get('/',function(req,res){
    //res.writeHead(200,{'Content-Type'})
    res.end('2131');
})

function dothis(uniqueid,resp){
    var uid = uniqueid;
    MongoClient.connect(url,function(err,db){
        var collection = db.collection('neural');
        collection.findOne({'uid' : uid},function(err,result){
        if(err){
            console.log(err);
        }
        else{
            console.log('%d data mil gya',result.prediction);
            var obj = {
                'prediction' : parseFloat(result.prediction)*100
            }
            resp.end(JSON.stringify(obj));
        }
      });

    });
}

function dothis2(uniqueid,resp){
    var uid = uniqueid;
    MongoClient.connect(url,function(err,db){
        var collection = db.collection('neural_loan');
        collection.findOne({'uid' : uid},function(err,result){
        if(err){
            console.log(err);
        }
        else{
            console.log('%d data mil gya',result.prediction);
            var obj = {
                'prediction' : parseFloat(result.prediction)*100
            }
            resp.end(JSON.stringify(obj));
        }
      });

    });
}


app.get('/api/v1/mobile',function(req,res){
    var _uid = shortid.generate();
    var req_json = {
        'uid' : _uid,
        'etpd' : req.query.etpd,
        'locpop' : req.query.locpop,
        'weektraffic' : req.query.weektraffic,
        'weekdaytraffic' : req.query.weekdaytraffic,
        'etsize' : req.query.etsize,
        'serviceroutes' : req.query.serviceroutes,
        'atminprox' : req.query.atminprox,
        'ownatm' : req.query.ownatm,
        'nearatm' : req.query.nearatm,
        'lease' : req.query.lease,
        'mpot' : req.query.mpot,
        'comm' : req.query.comm,
        'crimerate' : req.query.crimerate,
        'servicecost' : req.query.servicecost,
        'prediction' : 0
    }
    console.log(_uid);
    MongoClient.connect(url,function(err,db){
        if(err){
            console.log(err);
        }
        else{
            var collection = db.collection('neural');
            collection.insert(req_json,function(err,resp){
                if(err){
                    console.log(err);
                }
                else{
                    console.log("%d Schema Entered",resp.insertedCount);
                }
                console.log('python now');
                exec('python main.py -id ' + _uid ,(error,stdout,stderr)=>{
                  if (error){
                    console.log('Error: ' + error);
                    return;
                  }
                  console.log('maybe it works');
                  console.log('StdError: ' + stderr);
                  console.log('StdOut: ' + stdout);
                  console.log('trying to fetch');
                  db.close();
                  dothis(_uid,res);
                  
                });

                db.close();

            });
        }
    });
})
// https:/192.168.1.164:7700/api/v1/web?Gender=0&Dob=0&PIN=0&Curr_res_yr=0&Curr_res=0&Rent=0&Deps=0&Marital=0&Qualification=0&Credit_score=0&Religion=0&Category=0&Res_stat=0&Occupation=0&Salaried=0&
// Avg_monthly_exp=0&Prop=0&Veh=0&FD=0&PPF=0&PF=0&Investments=0&SLIP=0&Amt=0&Tenor=0

app.get('/api/v1/web',function(req,res){
    var _uid = shortid.generate();
    var req_json = {
        'uid' : _uid,
        'Gender':req.query.Gender,
        'Dob':req.query.Dob,
        'PIN' : req.query.PIN,
        'Curr_res_yr' : req.query.Curr_res_yr,
        'Curr_res':req.query.Curr_res,
        'Rent' :req.query.Rent,
        'Deps' :req.query.Deps,
        'Marital' : req.query.Marital,
        'Qualification':req.query.Qualification,
        'Credit_score':req.query.Credit_score,
        'Religion':req.query.Religion,
        'Category':req.query.Category,
        'Res_stat':req.query.Res_stat,
        'Occupation':req.query.Occupation,
        'Salaried':req.query.Salaried,
        'Emp_pin':req.query.Emp_pin,
        'Avg_monthly_exp':req.query.Avg_monthly_exp,
        'Prop':req.query.Prop,
        'Veh':req.query.Veh,
        'FD':req.query.FD,
        'PPF':req.query.PPF,
        'PF':req.query.PF,
        'Investments':req.query.Investments,
        'SLIP':req.query.SLIP,
        'Amt':req.query.Amt,
        'Tenor':req.query.Tenor,
        'Curr_emp_yr':req.query.Curr_emp_yr,
        'Gross_monthly_in':req.query.Gross_monthly_in,
        'Net_monthly_in':req.query.Net_monthly_in,
        'prediction':0
    }

    console.log(_uid);

    MongoClient.connect(url,function(err,db){
        if(err){
            console.log(err);
        }
        else{
            var collection = db.collection('neural_loan');
            collection.insert(req_json,function(err,resp){
                if(err){
                    console.log(err);
                }
                else{
                    console.log("%d Schema Entered",resp.insertedCount);
                }
                console.log('python now');
                exec('python main_loan.py -id ' + _uid,(error,stdout,stderr)=>{
                    if(error){
                        console.log(error);
                        return;
                    }
                    console.log('maybe it works as well!');
                    console.log('StdError: ' + stderr);
                    console.log('StdOut: ' + stdout);
                    console.log('trying to fetch');
                    db.close();
                    dothis2(_uid,res);

                });
                db.close();
            });
        }
    });
})

app.listen(7700,()=>{
    console.log('API up and running on 7700');
})