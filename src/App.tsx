import { models, service } from 'powerbi-client';
import { PowerBIEmbed } from 'powerbi-client-react';
import 'powerbi-report-authoring';
import React, { useEffect, useState } from 'react';
import './App.css';
import reportConfig from './Config';

function App() {
  // Report config useState hook
  // accessToken is actually called "Embed Token". Access Token is something different
  const [sampleReportConfig, setReportConfig] = useState<models.IReportEmbedConfiguration>({
    type: 'report',
    embedUrl: undefined,
    tokenType: models.TokenType.Embed,
    accessToken: undefined,
    settings: {
      panes: {
        filters: {
          expanded: false,
          visible: true,
        },
      },
    },
  });

  // Map of event handlers to be applied to the embedding report
  const eventHandlersMap = new Map([
    [
      'loaded',
      function () {
        console.log('Report has loaded');
      },
    ],
    [
      'rendered',
      function () {
        console.log('Report has rendered');
      },
    ],
    [
      'error',
      function (event?: service.ICustomEvent<any>) {
        if (event) {
          console.error(event.detail);
        }
      },
    ],
  ]);

  useEffect(() => {
    // Set the fetched embedUrl and embedToken in the report config
    setReportConfig({
      ...sampleReportConfig,
      embedUrl: reportConfig.embedUrl,
      accessToken: reportConfig.accessToken,
    });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const header = (
    <div className='header'>
      <div className='title'>Power BI Embed</div>
    </div>
  );

  return (
    <div>
      {header}
      <PowerBIEmbed embedConfig={sampleReportConfig} eventHandlers={eventHandlersMap} cssClassName={'report-style-class'} />

      <div className='hr'></div>
    </div>
  );
}

export default App;
