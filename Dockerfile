FROM openjdk:8-jre-slim
ARG JMETER_VERSION
ARG JMETER_PLUGIN_VERSION="1.4.0"

ENV JMETER_VERSION ${JMETER_VERSION:-5.3}
ENV JMETER_HOME /jmeter/apache-jmeter-$JMETER_VERSION/
ENV PATH $JMETER_HOME/bin:$PATH
ENV JMETER_PLUGINS_DOWNLOAD_URL https://repo1.maven.org/maven2/kg/apc
ENV JMETER_PLUGINS_FOLDER ${JMETER_HOME}/lib/ext/


# INSTALL PRE-REQ
RUN apt-get update && \
    apt-get -y install \
    wget

# INSTALL JMETER BASE
RUN mkdir /jmeter
WORKDIR /jmeter

RUN wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz && \
    tar -xzf apache-jmeter-$JMETER_VERSION.tgz && \
    rm apache-jmeter-$JMETER_VERSION.tgz
    #mkdir /jmeter-plugins && \
    #cd /jmeter-plugins/ && \
    #get Jmere plugins
    #wget https://jmeter-plugins.org/downloads/file/JMeterPlugins-ExtrasLibs-1.4.0.zip && \
    #wget https://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-1.4.0.zip && \
    #wget https://jmeter-plugins.org/downloads/file/JMeterPlugins-WebDriver-1.4.0.zip
    #unzip -o JMeterPlugins-ExtrasLibs-1.4.0.zip -d /$JMETER_PLUGINS_FOLDER/apache-jmeter-$JMETER_VERSION && \
    #unzip -o JMeterPlugins-ExtrasLibs-1.4.0.zip -d /$JMETER_PLUGINS_FOLDER/apache-jmeter-$JMETER_VERSION && \
    #unzip -o JMeterPlugins-ExtrasLibs-1.4.0.zip -d /$JMETER_PLUGINS_FOLDER/apache-jmeter-$JMETER_VERSION


RUN apt-get update \
    && apt-get install -y curl

#RUN curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-dummy/0.2/jmeter-plugins-dummy-0.2.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-dummy-0.2.jar
RUN curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-standard/${JMETER_PLUGIN_VERSION}/jmeter-plugins-standard-${JMETER_PLUGIN_VERSION}.jar   -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-standard-${JMETER_PLUGIN_VERSION}.jar
RUN curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-extras/${JMETER_PLUGIN_VERSION}/jmeter-plugins-extras-${JMETER_PLUGIN_VERSION}.jar   -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-extras-${JMETER_PLUGIN_VERSION}.jar
RUN curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-extras-libs/${JMETER_PLUGIN_VERSION}/jmeter-plugins-extras-libs-${JMETER_PLUGIN_VERSION}.jar   -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-extras-libs-${JMETER_PLUGIN_VERSION}.jar
RUN curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-cmn-jmeter/0.6/jmeter-plugins-cmn-jmeter-0.6.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-cmn-jmeter-0.6.jar
RUN curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-casutg/2.9/jmeter-plugins-casutg-2.9.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-casutg-2.9.jar
RUN curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-graphs-additional/2.0/jmeter-plugins-graphs-additional-2.0.jar  -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-graphs-additional-2.0.jar
RUN curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-fifo/0.2/jmeter-plugins-fifo-0.2.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-fifo-0.2.jar
RUN curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-tst/2.5/jmeter-plugins-tst-2.5.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-tst-2.5.jar
RUN curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-perfmon/2.1/jmeter-plugins-perfmon-2.1.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-perfmon-2.1.jar




WORKDIR $JMETER_HOME

COPY jmeterStartup.sh /jmeter/jmeterStartup.sh

# setup executable permission to docker
RUN chmod +x /jmeter/jmeterStartup.sh


EXPOSE 1099 26000
ENTRYPOINT ["/jmeter/jmeterStartup.sh"]
