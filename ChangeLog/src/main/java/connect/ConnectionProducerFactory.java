package connect;

import java.io.IOException;
import java.util.logging.Logger;

/**
 * Фабрика создания подключений к БД
 * @author bisirkin_pv
 */
public class ConnectionProducerFactory {
    private static final Logger LOG = Logger.getLogger(ConnectionProducerFactory.class.getName());

    private ConnectionProducerFactory() {
    }

    public static synchronized ConnectionProducer create(Config.Type connectionProducerType) throws IOException {
        ConnectionProducer connectionProducer = null;
        switch (connectionProducerType) {
            case PROD:
                connectionProducer = new MsSqlConnectionProducer(Config.getValue(Config.Type.PROD,"connection.url")
                        , Config.getValue(Config.Type.PROD,"username")
                        , Config.getValue(Config.Type.PROD,"password"));
                break;
            case TEST:
                connectionProducer = new MsSqlConnectionProducer(Config.getValue(Config.Type.TEST,"connection.url")
                        , Config.getValue(Config.Type.TEST,"username")
                        , Config.getValue(Config.Type.TEST,"password"));
                break;
            default:
                new UnsupportedOperationException("Unsupported: " + connectionProducerType.name());
        }

        return connectionProducer;
    }
}