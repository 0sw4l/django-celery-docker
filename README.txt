# SERVER /opt/app/

# MONTAR ENTORNO POR PRIMERA VEZ

	# CONFIGURAR VARIABLES DE ENTORNO
	cp env.template .env

	# EJEMPLO DE .env

	LANG=C.UTF-8
	LC_ALL=C.UTF-8
	SECRET_KEY=#DJANGO SECRET_KEY
	DEBUG=false
	HTTPS=on
	POSTGRES_DB=#NOMBRE QUE SE QUIERE DAR A LA BASE DE DATOS
	POSTGRES_USER=#USUARIO
	POSTGRES_PASSWORD=#PASSWORD

	# CREAR IMAGENES PARA django-celery-docker
	docker-compose -f prod.yml build

# INICIAR SERVIDOR

docker-compose -f prod.yml up -d

# CREAR EL MODELO DE DATOS EN LA BASE DE DATOS EN PRODUCCION

docker-compose -f prod.yml exec app python manage.py makemigrations
docker-compose -f prod.yml exec app python manage.py migrate

# REINICIAR LOS SERVICIOS PARA QUE CARGUE CORRECTAMENTE CELERY

docker-compose -f prod.yml restart beat

# COMPROBAR EL ESTADO DEL BACKEND

docker-compose -f prod.yml ps

# CREAR UN USUARIO ADMINISTRADOR EN NUESTRO BACKEND

docker-compose -f prod.yml exec app python manage.py createsuperuser

# CREAR static files

docker-compose -f prod.yml exec app python manage.py collectstatic


# show logs
docker-compose logs -f app

# estado de los procesos
docker-compose ps
