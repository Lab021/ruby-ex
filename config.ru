require 'rack/lobster'

map '/health' do
  health = proc do |env|
    [200, { "Content-Type" => "text/html" }, ["1"]]
  end
  run health
end

map '/lobster' do
  run Rack::Lobster.new
end

map '/headers' do
  headers = proc do |env|
    [200, { "Content-Type" => "text/plain" }, [
      env.select {|key,val| key.start_with? 'HTTP_'}
      .collect {|key, val| [key.sub(/^HTTP_/, ''), val]}
      .collect {|key, val| "#{key}: #{val}"}
      .sort
      .join("\n")
    ]]
  end
  run headers
end

map '/' do
  welcome = proc do |env|
    [200, { "Content-Type" => "text/html" }, [<<WELCOME_CONTENTS
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Welcome to OpenShift</title>


<style>

/*!
 * Bootstrap v3.0.0
 *
 * Copyright 2013 Twitter, Inc
 * Licensed under the Apache License v2.0
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Designed and built with all the love in the world @twitter by @mdo and @fat.
 */
*, *:before, *:after {
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
aside,
footer,
header,
hgroup,
section{
  display: block;
}
body {
  color: #404040;
  font-family: "Helvetica Neue",Helvetica,"Liberation Sans",Arial,sans-serif;
  font-size: 14px;
  line-height: 1.4;
}

html {
  font-family: sans-serif;
  -ms-text-size-adjust: 100%;
  -webkit-text-size-adjust: 100%;
}
ul {
    margin-top: 0;
}
.container {
  margin-right: auto;
  margin-left: auto;
  padding-left: 15px;
  padding-right: 15px;
}
.container:before,
.container:after {
  content: " ";
  /* 1 */

  display: table;
  /* 2 */

}
.container:after {
  clear: both;
}
.row {
  margin-left: -15px;
  margin-right: -15px;
}
.row:before,
.row:after {
  content: " ";
  /* 1 */

  display: table;
  /* 2 */

}
.row:after {
  clear: both;
}
.col-sm-6, .col-md-6, .col-xs-12 {
  position: relative;
  min-height: 1px;
  padding-left: 15px;
  padding-right: 15px;
}
.col-xs-12 {
  width: 100%;
}

@media (min-width: 768px) {
  .container {
    width: 750px;
  }
  .col-sm-6 {
    float: left;
  }
  .col-sm-6 {
    width: 50%;
  }
}

@media (min-width: 992px) {
  .container {
    width: 970px;
  }
  .col-md-6 {
    float: left;
  }
  .col-md-6 {
    width: 50%;
  }
}
@media (min-width: 1200px) {
  .container {
    width: 1170px;
  }
}

a {
  color: #069;
  text-decoration: none;
}
a:hover {
  color: #EA0011;
  text-decoration: underline;
}
hgroup {
  margin-top: 50px;
}
footer {
    margin: 50px 0 25px;
}
h1, h2, h3 {
  color: #000;
  line-height: 1.38em;
  margin: 1.5em 0 .3em;
}
h1 {
  font-size: 25px;
  font-weight: 300;
  border-bottom: 1px solid #fff;
  margin-bottom: .5em;
}
h1:after {
  content: "";
  display: block;
  width: 100%;
  height: 1px;
  background-color: #ddd;
}
h2 {
  font-size: 19px;
  font-weight: 400;
}
h3 {
  font-size: 15px;
  font-weight: 400;
  margin: 0 0 .3em;
}
p {
  margin: 0 0 2em;
  text-align: justify;
}
p + h2 {
  margin-top: 2em;
}
html {
  background: #f5f5f5;
  height: 100%;
}
code {
  background-color: white;
  border: 1px solid #ccc;
  padding: 1px 5px;
  color: #888;
}
pre {
  display: block;
  padding: 13.333px 20px;
  margin: 0 0 20px;
  font-size: 13px;
  line-height: 1.4;
  background-color: #fff;
  border-left: 2px solid rgba(120,120,120,0.35);
  white-space: pre;
  white-space: pre-wrap;
  word-break: normal;
  word-wrap: break-word;
  overflow: auto;
  font-family: Menlo,Monaco,"Liberation Mono",Consolas,monospace !important;
}

</style>

</head>
<body>

<section class='container'>
          <hgroup>
            <h1>Welcome to your Ruby application on OpenShift</h1>
          </hgroup>


        <div class="row">
          <section class='col-xs-12 col-sm-6 col-md-6'>
            <section>
              <h2>Deploying code changes</h2>
                <p>
                  The source code for this application is available to be forked from the <a href="https://www.github.com/sclorg/ruby-ex">OpenShift GitHub repository</a>.
                  You can configure a webhook in your repository to make OpenShift automatically start a build whenever you push your code:
                </p>

<ol>
  <li>From the Web Console homepage, navigate to your project</li>
  <li>Click on Browse &gt; Builds</li>
  <li>From the view for your Build click on the button to copy your GitHub webhook</li>
  <li>Navigate to your repository on GitHub and click on repository settings &gt; webhooks</li>
  <li>Paste your webhook URL provided by OpenShift &mdash; that's it!</li>
</ol>
<p>After you save your webhook, if you refresh your settings page you can see the status of the ping that Github sent to OpenShift to verify it can reach the server.</p>
<p>Note: adding a webhook requires your OpenShift server to be reachable from GitHub.</p>

                <h3>Working in your local Git repository</h3>
                <p>If you forked the application from the OpenShift GitHub example, you'll need to manually clone the repository to your local system. Copy the application's source code Git URL and then run:</p>

<pre>$ git clone &lt;git_url&gt; &lt;directory_to_create&gt;

# Within your project directory
# Commit your changes and push to OpenShift

$ git commit -a -m 'Some commit message'
$ git push</pre>

<p>After pushing changes, you'll need to manually trigger a build if you did not setup a webhook as described above.</p>
      </section>
          </section>
          <section class="col-xs-12 col-sm-6 col-md-6">

                <h2>Managing your application</h2>

                <p>Documentation on how to manage your application from the Web Console or Command Line is available at the <a href="http://docs.okd.io/latest/dev_guide/overview.html">Developer Guide</a>.</p>

                <h3>Web Console</h3>
                <p>You can use the Web Console to view the state of your application components and launch new builds.</p>

                <h3>Command Line</h3>
                <p>With the <a href="http://docs.okd.io/latest/cli_reference/overview.html">OpenShift command line interface</a> (CLI), you can create applications and manage projects from a terminal.</p>

                <h2>Development Resources</h2>
                  <ul>
                    <li><a href="http://docs.okd.io/latest/welcome/index.html">OpenShift Documentation</a></li>
                    <li><a href="https://github.com/openshift/origin">Openshift Origin GitHub</a></li>
                    <li><a href="https://github.com/openshift/source-to-image">Source To Image GitHub</a></li>
                    <li><a href="http://docs.okd.io/latest/using_images/s2i_images/ruby.html">Getting Started with Ruby on OpenShift</a></li>
                    <li><a href="http://stackoverflow.com/questions/tagged/openshift">Stack Overflow questions for OpenShift</a></li>
                    <li><a href="http://git-scm.com/documentation">Git documentation</a></li>
                  </ul>


          </section>
        </div>

        <footer>
          <div>코메리<a href="https://www.openshift.com/"></a></div>
        </footer>
</section>


</body>
</html>
WELCOME_CONTENTS
    ]]
  end
  run welcome
end
