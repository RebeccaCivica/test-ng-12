FROM node:14
	# stage 1

	FROM node:alpine AS my-app-build
	WORKDIR /app
	COPY . .
	# RUN BUILDENV
	RUN npm install && npm run build --prod

	# stage 2

	FROM nginx:alpine
	COPY --from=my-app-build /dist/angular12-dojo /usr/share/nginx/html
	COPY --from=my-app-build /nginx.conf /etc/nginx/conf.d/default.conf
	EXPOSE 80