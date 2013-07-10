from bottle import *
import sqlite3, json 



HOSTNAME = 'localhost'
baseDir = '/home/weinbergmath/webapps/shapes/'


def createDatabase():
    
    database = sqlite3.connect(baseDir + 'halffull.db')
    database.execute("CREATE TABLE halffull (id INTEGER PRIMARY KEY, rectangle char(10) NOT NULL, trapezoid char(10) NOT NULL, triangle char(10) NOT NULL,parabola char(10) NOT NULL  )")
    database.commit()

#createDatabase()

def retrieveData():
    conn = sqlite3.connect(baseDir+'halffull.db')
    c = conn.cursor()
    c.execute("SELECT rectangle,trapezoid,triangle,parabola FROM halffull ORDER BY id DESC")
    data = c.fetchall()
    return data[0:99]




def addData(rectangle, trapezoid, triangle, parabola):
    
    conn = sqlite3.connect(baseDir+'halffull.db')
    c = conn.cursor()
    c.execute("SELECT rectangle,trapezoid,triangle,parabola FROM halffull ORDER BY id DESC")
    lastData = c.fetchone()
    conn.close()
 
    if(lastData[3]!=parabola):
        database = sqlite3.connect(baseDir+'halffull.db')
        database.execute("INSERT INTO halffull(rectangle,trapezoid,triangle,parabola) VALUES (?,?,?,?)",(rectangle,trapezoid,triangle,parabola))
        database.commit()


@route('/halffull/')
def showPage():



    return template(baseDir +'halffull.tpl')

@route('/halffull/2/')
def showPage():



    return template(baseDir +'halffull-trap.tpl')

@route('/halffull/3/')
def showPage():



    return template(baseDir +'halffull-tr.tpl')

@route('/halffull/4/')
def showPage():



    return template(baseDir +'halffull-par.tpl')

@route('/halffull/1P/')
def showPage():



    return template(baseDir +'halffullP.tpl')

@route('/halffull/2P/')
def showPage():



    return template(baseDir +'halffullP-trap.tpl')

@route('/halffull/3P/')
def showPage():



    return template(baseDir +'halffullP-tr.tpl')

@route('/halffull/4P/')
def showPage():



    return template(baseDir +'halffullP-par.tpl')

@route('/halffull/q/')
def showQuestion():


    return template(baseDir + 'halffullF-tr.tpl')




@post('/ajax/')
def getData():
        rectangle= request.json['rectangle']
        trapezoid = request.json['trapezoid']
        triangle = request.json['triangle']
        parabola = request.json['parabola']
        testString = rectangle + ' ' + trapezoid + ' ' + triangle + ' ' + parabola
        #print(testString)
        addData(rectangle,trapezoid,triangle,parabola)
        
        return testString

@get("/halffull/data/")
def showData():
    data = retrieveData()
    dataList = []

    for row in data:
        t = ( row[0], row[1],row[2],row[3])
        dataList.append(t)

    
    outputData = json.dumps(dataList)
    response.content_type="application/javascript"
    outputData = "processData("+str(outputData)+");"
    return outputData

@get("/halffull/len/")
def getSize():
    conn = sqlite3.connect(baseDir+'halffull.db')
    c = conn.cursor()
    c.execute("SELECT id FROM halffull ORDER BY id DESC")
    data = c.fetchall()
    return str(data[0])

@post('/myValue/')
def getYourGuess():
    myGuess = request.json['myGuess']
    outFile = open(baseDir+'guessData','a')
    outFile.write('\n'+str(myGuess))
    outFile.close()
       

run(host = HOSTNAME,port = 8080, debug = True)
#application = default_app()
