USE master
GO
IF NOT EXISTS (
   SELECT name
   FROM sys.databases
   WHERE name = N'CHANGELOG'
)
CREATE DATABASE CHANGELOG
GO

USE CHANGELOG
GO

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID('dbo.tChangeLog')=OBJECT_ID)
	DROP TABLE dbo.tChangeLog
GO
CREATE TABLE dbo.tChangeLog
(
     id             INT IDENTITY(1,1)                    NOT NULL
    ,[version]      VARCHAR(10)                          NOT NULL
    ,dt             DATE DEFAULT CAST(GETDATE() AS DATE) NOT NULL
    ,issue          INT                                  NULL
    ,issueUrl       VARCHAR(1000)                        NULL
    ,[description]  VARCHAR(3000)                        NULL
    ,comment        VARCHAR(3000)                        NULL
    ,developer      VARCHAR(100)                         NULL
    ,svnCopyTo      INT                                  NULL
    ,svnCommit      INT                                  NULL
    ,isDev          BIT DEFAULT 0                        NOT NULL
    CONSTRAINT pkChangeLog PRIMARY KEY CLUSTERED (id)   
)

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Таблица хранит лог разработки',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLog'

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Уникальный номер задачи',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLog',  
    @level2type = N'Column', @level2name = 'id';

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Версия проекта',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLog',  
    @level2type = N'Column', @level2name = 'version';

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'дата поставки/завершения разработки',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLog',  
    @level2type = N'Column', @level2name = 'dt';

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Номер задачи',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLog',  
    @level2type = N'Column', @level2name = 'issue';  

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Ссылка на задачу',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLog',  
    @level2type = N'Column', @level2name = 'description';  

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'краткое описание (название)',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLog',  
    @level2type = N'Column', @level2name = 'comment';  

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Разработчик',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLog',  
    @level2type = N'Column', @level2name = 'developer';  

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Последний commit',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLog',  
    @level2type = N'Column', @level2name = 'svnCopyTo';  

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Merge commit',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLog',  
    @level2type = N'Column', @level2name = 'svnCommit'; 

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Флаг в разработке. 0-dev, 1-deploy',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLog',  
    @level2type = N'Column', @level2name = 'isDev'; 
    
IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID('dbo.vChangeLogObject')=OBJECT_ID)
	DROP VIEW dbo.vChangeLogObject
GO
IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID('dbo.tChangeLogObject')=OBJECT_ID)
	DROP TABLE dbo.tChangeLogObject
CREATE TABLE dbo.tChangeLogObject
(
     id             INT IDENTITY(1,1) NOT NULL
    ,clId           INT               NOT NULL
    ,changeType     BIT DEFAULT 0     NOT NULL
    ,objName        VARCHAR(1000)         NULL
    ,[description]  VARCHAR(2000)         NULL
    CONSTRAINT fkChangeLogObjectToChangeLog FOREIGN KEY(clId)
        REFERENCES dbo.tChangeLog (id)     
        ON DELETE CASCADE    
        ON UPDATE CASCADE   
)

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Таблица хранит объекты измененные в ходе разработки по задачи',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLogObject'

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Номер лога',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLogObject',  
    @level2type = N'Column', @level2name = 'clId';

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Тип измененного объекта.  0- основные объекты, 1 - дополнительные',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLogObject',  
    @level2type = N'Column', @level2name = 'changeType';

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Уникальный номер объекта',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLogObject',  
    @level2type = N'Column', @level2name = 'objName';

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Уникальный номер объекта',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLogObject',  
    @level2type = N'Column', @level2name = 'description';

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID('dbo.vChangeLogObject')=OBJECT_ID)
	DROP VIEW dbo.vChangeLogObject
GO
CREATE VIEW dbo.vChangeLogObject
WITH SCHEMABINDING
AS
SELECT 
     id
    ,clId
    ,changeType
    ,objName
    ,description
FROM dbo.tChangeLogObject
;
GO

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Представление по измененным объектам',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'View',  @level1name = 'vChangeLogObject'

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID('dbo.vChangeLogCrossing')=OBJECT_ID)
	DROP VIEW dbo.vChangeLogCrossing
GO
CREATE VIEW dbo.vChangeLogCrossing 
AS
WITH ChangeLogObject AS
(
    SELECT DISTINCT
         tclo.clId
        ,tclo.clIdCros
        ,tcl.issue
    FROM (
        SELECT DISTINCT       
                tclo.clId
                ,tclo.objName      
                ,tclcros.clId AS clIdCros   
        FROM dbo.tChangeLogObject tclo
        JOIN dbo.tChangeLogObject tclcros
            ON tclo.objName = tclcros.objName
            AND tclo.clId <> tclcros.clId
    ) tclo
    JOIN dbo.tChangeLog tcl
        ON tcl.id = tclo.clIdCros       
)
SELECT     
     clo.clId
    ,LEFT(crossIssue, LEN(crossIssue)-1) crossIssue
FROM(
    SELECT clo.clId, (
        SELECT DISTINCT
            CAST(clo2.issue AS VARCHAR(10)) +',' AS 'data()' 
        FROM ChangeLogObject clo2
        WHERE clo2.clId = clo.clId FOR XML PATH('')
    ) crossIssue
    FROM ChangeLogObject clo
    GROUP BY clo.clId
) clo
;
GO
EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Представление отображает номера задач с пересекающимися объектами',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'View',  @level1name = 'vChangeLogCrossing'

GO

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID('dbo.vChangeLog')=OBJECT_ID)
	DROP VIEW dbo.vChangeLog
GO
CREATE VIEW dbo.vChangeLog AS
SELECT 
     tcl.id
    ,tcl.[version]
    ,CONVERT(VARCHAR(10),tcl.dt,104) AS dt
    ,tcl.issue
    ,tcl.issueUrl
    ,tcl.[description]
    ,COALESCE(tcl.comment,'') AS comment
    ,tcl.developer
    ,tcl.svnCopyTo
    ,tcl.svnCommit
    ,tcl.isDev
    ,tcl.developer AS fio
    ,vclc.crossIssue
FROM dbo.tChangeLog tcl
LEFT JOIN dbo.vChangeLogCrossing vclc
    ON tcl.id = vclc.clId
;
GO
EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Представление отображает информацию по логу разработки',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'View',  @level1name = 'vChangeLog'

GO

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID('dbo.fncChangeLogFilterPrepare')=OBJECT_ID)
	DROP FUNCTION dbo.fncChangeLogFilterPrepare
GO
CREATE FUNCTION dbo.fncChangeLogFilterPrepare
(
     @object VARCHAR(500)
    ,@type   VARCHAR(10)
)RETURNS VARCHAR(500)
AS
BEGIN
    DECLARE @result VARCHAR(300)
    SET @result = CASE WHEN @object <> '-1' 
                         THEN
                            CASE @type
                                WHEN 'contains' THEN CONCAT('%',@object,'%')
                                WHEN 'begin'    THEN CONCAT(    @object,'%')
                                WHEN 'end'      THEN CONCAT('%',@object    )
                                ELSE @object
                            END
                        ELSE @object
                    END
    RETURN @result
END
;
GO

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Подготовка текста запроса поиска объекта для расширенного фильтра',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Function',  @level1name = 'fncChangeLogFilterPrepare'


IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID('dbo.fncChangeLogFilter')=OBJECT_ID)
	DROP FUNCTION dbo.fncChangeLogFilter
GO
CREATE FUNCTION dbo.fncChangeLogFilter
(
     @version    VARCHAR(10)  = null
    ,@issue      VARCHAR(10)  = null
    ,@objectName VARCHAR(300) = null
    ,@versionSearchType      VARCHAR(20) = null
    ,@issueSearchType        VARCHAR(20) = null
    ,@objectNameSearchType   VARCHAR(20) = null
)
RETURNS TABLE 
AS
RETURN
    SELECT DISTINCT 
         tcl.id  AS clId
        ,tclo.id AS objectId
    FROM dbo.tChangeLog tcl
    JOIN dbo.tChangeLogObject tclo
        ON tcl.id = tclo.clId
    WHERE 1=1
        AND tcl.version  LIKE IIF(@version = ''
                                    ,tcl.version 
                                    ,dbo.fncChangeLogFilterPrepare(@version,@versionSearchType)
                                )
        AND CAST(tcl.issue AS VARCHAR(10)) LIKE IIF(@issue = '-1'
                                                        ,CAST(tcl.issue AS VARCHAR(10))
                                                        ,dbo.fncChangeLogFilterPrepare(@issue,@issueSearchType)
                                                    )
        AND tclo.objName LIKE IIF(@objectName = ''
                                    ,tclo.objName
                                    ,dbo.fncChangeLogFilterPrepare(@objectName,@objectNameSearchType)
                                )
;
GO

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Расширенный фильтр, возвращает найденные объекты',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Function',  @level1name = 'fncChangeLogFilter'


IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID('dbo.fncChangeLogGetCurrentVerison')=OBJECT_ID)
	DROP FUNCTION dbo.fncChangeLogGetCurrentVerison
GO
CREATE FUNCTION dbo.fncChangeLogGetCurrentVerison()
RETURNS TABLE 
AS
RETURN
(
    SELECT
        MAX(version) AS [VERSION]
    FROM dbo.tChangeLog WITH (NOLOCK) 
    WHERE 1=1
        AND isDev = 0
)
;
GO

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Возвращает последнюю версию на бою',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Function',  @level1name = 'fncChangeLogGetCurrentVerison'

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID('dbo.vChangeLogDeveloper')=OBJECT_ID)
	DROP VIEW dbo.vChangeLogDeveloper
GO
CREATE VIEW dbo.vChangeLogDeveloper
AS
    SELECT DISTINCT 
         tcl.developer
        ,tcl.developer AS NAME
    FROM dbo.tChangeLog tcl
;
GO

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Список пользователей заносовших информацию',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'View',  @level1name = 'vChangeLogDeveloper'

IF	EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID('dbo.tChangeLogQuery')=OBJECT_ID)
		DROP TABLE dbo.tChangeLogQuery
GO
CREATE TABLE dbo.tChangeLogQuery
(
     id INT IDENTITY(1,1)   /* id запроса */
    ,name VARCHAR(100)      /* Название */
    ,text VARCHAR(MAX)      /* Текст запроса */
     CONSTRAINT pkChangeLogQuery PRIMARY KEY CLUSTERED (id)  
)
GO

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Таблица хранит запросы выполняемые в приложении',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLogQuery'

EXEC sp_addextendedproperty
    @name = N'description',   
    @value = 'id запроса',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLogQuery',  
    @level2type = N'Column', @level2name = 'id';

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Название',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLogQuery',  
    @level2type = N'Column', @level2name = 'name';

EXEC sp_addextendedproperty  
    @name = N'description',
    @value = 'Текст запроса',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'Table',  @level1name = 'tChangeLogQuery',  
    @level2type = N'Column', @level2name = 'text';

IF	EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID('dbo.vChangeLogQuery')=OBJECT_ID)
		DROP VIEW dbo.vChangeLogQuery
GO
CREATE VIEW dbo.vChangeLogQuery
AS
SELECT 
     id
    ,name
    ,text 
FROM dbo.tChangeLogQuery
;
GO

EXEC sp_addextendedproperty   
    @name = N'description',   
    @value = 'Представление отображает запросы для выполнения в приложении',  
    @level0type = N'Schema', @level0name = 'dbo',  
    @level1type = N'View',  @level1name = 'vChangeLogQuery'

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('getAllHeader','
SELECT 
     cl.id
    ,cl.[version]
    ,cl.dt
    ,cl.issue
    ,cl.issueUrl
    ,cl.[description]
    ,cl.comment
    ,cl.developer
    ,cl.svnCopyTo
    ,cl.svnCommit
    ,cl.isDev
    ,cl.fio
    ,cl.crossIssue
FROM dbo.vChangeLog cl 
ORDER BY version DESC, dt DESC;')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('insertHeader','
INSERT INTO dbo.tChangeLog (version, dt, issue, issueUrl, description, comment, developer, svnCopyTo, svnCommit, isDev)
VALUES (:version, :dt, :issue, :issueUrl, :description, :comment, :developer, :svnCopyTo, :svnCommit, :isDev);')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('updHeader','
UPDATE dbo.tChangeLog 
   SET  version        = :version
       ,dt             = :dt
       ,issue          = :issue
       ,issueUrl       = :issueUrl
       ,description    = :description
       ,comment        = :comment
       ,developer      = :developer
       ,svnCopyTo      = :svnCopyTo
       ,svnCommit      = :svnCommit
       ,isDev          = :isDev
WHERE id = :id;')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('getHeader','
SELECT 
     cl.id
    ,cl.[version]
    ,cl.dt
    ,cl.issue
    ,cl.issueUrl
    ,cl.[description]
    ,cl.comment
    ,cl.developer
    ,cl.svnCopyTo
    ,cl.svnCommit
    ,cl.isDev
    ,cl.fio
    ,cl.crossIssue
FROM dbo.vChangeLog cl
WHERE id = :id
ORDER BY version DESC, dt DESC;')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('insertDetail','
INSERT INTO dbo.tChangeLogObject (clid, objName, [description])
VALUES (:clid, :objName, :description)')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('getDetail','
SELECT 
     id
    ,changeType
    ,isnull(objName, '''') AS objName
    ,isnull([description], '''') AS [description] 
FROM dbo.vChangeLogObject 
WHERE clid = :id')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('getUserList','
SELECT 
     developer
    ,name
FROM dbo.vChangeLogDeveloper')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('getFilteredHeader','
SELECT
    clId
    ,objectId
FROM dbo.fncChangeLogFilter (:version,:issue,:objectName,:versionType,:issueType,:objectNameType)
ORDER BY clId DESC, objectId')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('getCurrentVersion','
SELECT 
    version 
FROM dbo.fncChangeLogGetCurrentVerison()')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('updateDetailName','
UPDATE tclo
    SET tclo.objName = :content
FROM dbo.tChangeLogObject tclo
WHERE id = :id;')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('updateDetailDesc','
UPDATE tclo
    SET tclo.description = :content        
FROM dbo.tChangeLogObject tclo
WHERE id = :id;')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('removeDetail','
DELETE FROM dbo.tChangeLogObject
WHERE id = :id;')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('removeLog','
DELETE FROM dbo.tChangeLog
WHERE id = :id;')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('insertDetailName','
INSERT INTO dbo.tChangeLogObject (clId,objName) 
VALUES(:clid, :content)')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('insertDetailDesc','
INSERT INTO dbo.tChangeLogObject (clId,description) 
VALUES(:clid, :content)')

INSERT INTO dbo.tChangeLogQuery(name, text)
VALUES('getIssueInfo','
SELECT
    :issue issueId
    ,'''' issueName
    ,'''' [login]
    ,'''' endDevelopmentDt
    ,''Статус'' [status]')