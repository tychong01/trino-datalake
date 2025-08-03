# Trino Data Lake

A complete data lake solution using Trino, Apache Superset, and MinIO S3-compatible storage. This project provides a modern data analytics stack for querying and visualizing data stored in S3-compatible storage.

## 🏗️ Architecture

This project consists of three main components:

- **Trino**: Distributed SQL query engine for big data analytics
- **Apache Superset**: Modern data exploration and visualization platform
- **MinIO**: S3-compatible object storage for data lake

### Data Lake Architectures

The project supports multiple data lake architectures:

1. **Traditional Data Lake** (Hive)
   - Uses Hive metastore and Parquet format
   - Suitable for batch analytics and reporting

2. **Lakehouse Iceberg**
   - Apache Iceberg table format
   - ACID transactions and schema evolution
   - Time travel capabilities

3. **Lakehouse DeltaLake**
   - Delta Lake table format
   - ACID transactions and upserts
   - Streaming and batch processing support

## 📁 Project Structure

```
trino-datalake/
├── data/                          # MinIO data storage
│   ├── datalake/                  # Hive data lake bucket
│   │   └── housing/               # Housing dataset
│   ├── lakehouse/
│   │   ├── iceberg/               # Iceberg tables
│   │   └── deltalake/             # Delta Lake tables
├── ddls/                          # SQL DDL scripts
│   └── ddl_house_prices.sql      # House prices table schema
├── Dockerfiles/                   # Custom Docker images
│   └── Dockerfile.superset        # Superset with Trino connector
├── superset/                      # Superset configuration
├── trino/                         # Trino configuration
│   ├── etc/
│   │   ├── catalog/
│   │   │   └── hive.properties   # Hive catalog config
│   │   ├── node.properties       # Trino node config
│   │   └── trino.properties      # Trino server config
│   └── metastore/                # Hive metastore
└── docker-compose.yml            # Multi-container setup
```

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose
- Git

### Setup

1. **Clone the repository**
   ```bash
   git clone git@github.com:tychong01/trino-datalake.git
   cd trino-datalake
   ```

2. **Start the services**
   ```bash
   docker-compose up -d
   ```

3. **Wait for services to initialize** (this may take a few minutes on first run)

### Access the Services

Once all services are running, you can access:

- **Trino**: http://localhost:8080
  - Default credentials: None required for basic queries
  - Web UI for query execution and monitoring

- **Apache Superset**: http://localhost:8088
  - Username: `admin`
  - Password: `admin`
  - Dashboard and visualization platform

- **MinIO Console**: http://localhost:9001
  - Username: `minioadmin`
  - Password: `minioadmin`
  - S3-compatible storage management

## 📊 Data Lake Setup

### MinIO S3 Buckets

The project is configured with three main S3 buckets for different data lake architectures:

- **`datalake`** → Hive Data Lake
  - Traditional data lake using Hive metastore
  - Parquet format storage
  - SQL queries via Trino Hive connector

- **`lakehouse/iceberg`** → Lakehouse Iceberg
  - Apache Iceberg table format
  - ACID transactions and schema evolution
  - Time travel and rollback capabilities

- **`lakehouse/deltalake`** → Lakehouse DeltaLake
  - Delta Lake table format
  - ACID transactions and upserts
  - Streaming and batch processing support

### Current Dataset

The project includes a housing dataset with the following schema:

```sql
CREATE TABLE hive.housing.house_prices (
    price BIGINT,
    area BIGINT,
    bedrooms BIGINT,
    bathrooms BIGINT,
    stories BIGINT,
    mainroad VARCHAR,
    guestroom VARCHAR,
    basement VARCHAR,
    hotwaterheating VARCHAR,
    airconditioning VARCHAR,
    parking BIGINT,
    prefarea VARCHAR,
    furnishingstatus VARCHAR
)
WITH (
    format = 'PARQUET',
    external_location = 's3a://datalake/housing/'
);
```

### Adding New Data

1. **Upload data to MinIO**:
   - Access MinIO console at http://localhost:9001
   - Upload data to appropriate buckets:
     - `datalake/` for Hive data lake (Parquet format)
     - `lakehouse/iceberg/` for Iceberg tables
     - `lakehouse/deltalake/` for Delta Lake tables

2. **Create table schemas**:
   - Add DDL scripts to the `ddls/` directory
   - Execute them through Trino
   - Choose appropriate table format based on your use case:
     - Hive for simple analytics
     - Iceberg for ACID transactions and schema evolution
     - Delta Lake for streaming and batch processing

## 🔧 Configuration

### Trino Configuration

- **Hive Catalog**: Configured to connect to MinIO S3
- **Metastore**: File-based Hive metastore
- **S3 Endpoint**: `http://minio:9000`
- **Credentials**: `minioadmin/minioadmin`

### Superset Configuration

- **Trino Connection**: Automatically configured
- **Database URI**: `trino://trino:8080/hive`
- **Admin User**: `admin/admin`

## 🛠️ Development

### Customizing the Stack

1. **Add new catalogs**: Modify `trino/etc/catalog/`
2. **Update Superset**: Modify `Dockerfiles/Dockerfile.superset`
3. **Add datasets**: Upload to MinIO and create DDL scripts

### Stopping Services

```bash
docker-compose down
```

### Viewing Logs

```bash
docker-compose logs -f [service_name]
```

## 📈 Usage Examples

### Querying Data with Trino

Connect to Trino and run SQL queries:

```sql
-- List available schemas
SHOW SCHEMAS FROM hive;

-- Query house prices data
SELECT * FROM hive.housing.house_prices LIMIT 10;

-- Analyze price distribution
SELECT 
    furnishingstatus,
    AVG(price) as avg_price,
    COUNT(*) as count
FROM hive.housing.house_prices 
GROUP BY furnishingstatus;
```

### Creating Dashboards in Superset

1. Connect to Trino database in Superset
2. Create datasets from your tables
3. Build charts and dashboards
4. Share insights with your team

## 🔒 Security Notes

- Default credentials are used for development
- For production, change all default passwords
- Consider using environment variables for sensitive data
- Enable SSL/TLS for production deployments

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🆘 Troubleshooting

### Common Issues

1. **Port conflicts**: Ensure ports 8080, 8088, 9000, 9001 are available
2. **Permission issues**: Check Docker volume permissions
3. **Service startup failures**: Check logs with `docker-compose logs`

### Getting Help

- Check service logs: `docker-compose logs [service]`
- Verify connectivity: `docker-compose ps`
- Restart services: `docker-compose restart [service]`

---

**Happy Data Lake-ing! 🚀** 