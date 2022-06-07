<p>La Api se baso en al gema de Grape, esta integrado en el proyecto incluso se puede utilizar directo en heroku..
esta usa basic auth, consiste en crear un user (email, password..) y ponerlo en el auth de postman para ejecutar los GET, POST,etc..</p>
<ol>
    <li>Ir A la ruta GET para consultar los tweets.. Se debe poner email y pass, de lo contrario no arrojara nada..</li>
      <code><b>localhost:3000/api/v1/tweets</b></code>
      <li>La respuesta deberia ser</li>
       <code><b>{
    "id": 308,
    "tweet": "hola",
    "retweet_id": null,
    "likes_count": 0,
    "retweet_count": 0
        }
    </b></code>
    <li>Para buscar un tweet en especifo usar, recordar usar el basic auth de email,pw..</li>
    <code><b>localhost:3000/api/v1/tweets/AQUIVAELIDDELTWEET</b></code>
  <ul>
</ol>
<h3>Para crear un tweet ir a la ruta POST (usar basic auth..), cabe destacar que retweet id es un campo opcional y se puede hacer POST con tweet...) </h3>
<ol>
    <code><b>localhost:3000/api/v1/tweets</b></code>
    <li>El formato de la consulta debe ser</li>
    <code><b>{"tweet": "wenawena", "retweet_id": "1"}</b></code>
    <ul>
    <li>la respuesta deberia ser</li>
    <code><b>
    {
    "tweet": {
        "id": 309,
        "user_id": 101,
        "tweet": "wenawena",
        "created_at": "2021-12-29T22:51:28.722Z",
        "updated_at": "2021-12-29T22:51:28.722Z",
        "retweet_id": 1,
        "likes_count": 0,
        "retweet_count": 0
    },
    "message": "Tweet Created Successfull"
    }
    </b>
    </code>
</ol>



Heroku link : https://shielded-sands-58200.herokuapp.com/
