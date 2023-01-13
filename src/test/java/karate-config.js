function fn() {
	var env = karate.env; // getSystem.property
	var file_path = 'file:src/test/resources/config/FilePath.json';
	var hrApiServerData = 'file:src/test/resources/config/HRApiServerData.json';

	env = 'scrum'

	karate.log('karate.env value:', env);

	if (!env) {
		env = 'scrum'
	}

	var config = {
		env: env,
		file_path: file_path,
		hrApiServerData: hrApiServerData,
		username: '',
		password: ''
	}
	if (env == 'sit') {
		config.username = 'framework',
		config.password = '12345678'
	}


	return config;
}