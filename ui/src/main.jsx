import React, { useState } from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';

function App() {
  const [prompt, setPrompt] = useState('');
  const [response, setResponse] = useState('');
  const [loading, setLoading] = useState(false);

  const sendPrompt = async () => {
    if (!prompt.trim()) return;
    setLoading(true);
    setResponse('');
    try {
      const res = await fetch('http://localhost:8000/v1/chat/completions', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          model: 'local',
          messages: [{ role: 'user', content: prompt }]
        })
      });
      const data = await res.json();
      const msg = data?.choices?.[0]?.message?.content || JSON.stringify(data);
      setResponse(msg);
    } catch (e) {
      setResponse('Error: ' + e);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={{ maxWidth: '600px', margin: 'auto' }}>
      <h2>Unlimited LLM Demo</h2>
      <textarea
        rows={4}
        style={{ width: '100%' }}
        placeholder="Enter your prompt…"
        value={prompt}
        onChange={e => setPrompt(e.target.value)}
      />
      <br />
      <button onClick={sendPrompt} disabled={loading} style={{ marginTop: '0.5rem' }}>
        {loading ? 'Thinking…' : 'Send'}
      </button>
      <pre style={{ whiteSpace: 'pre-wrap', marginTop: '1rem', background: '#eee', padding: '0.5rem' }}>
        {response}
      </pre>
    </div>
  );
}

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);
