package connect;

import org.sql2o.Sql2o;

/**
 * Интерфейс для работы с базой используя Sql2o
 * @author bisirkin_pv
 */
public interface ConnectionProducer {
    Sql2o produceSql2o();
}