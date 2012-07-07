module.exports = (server) ->
    log = server.log
    db = server.db
    app = server.app
    
    log.debug "Setting up tables resource"
    
    app.get '/db/:databaseName/schemas/:schemaName/tables', (req, res) ->
        sql = "SELECT * FROM pg_tables WHERE schemaname LIKE '#{req.params.schemaName}'"
        db.query sql, res, (result) ->
            res.send
                children: (row.tablename for row in result.rows)
