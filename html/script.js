// Roleplay menu NUI script
const rpContainer = document.getElementById('rpContainer');
const rpCategories = document.getElementById('rpCategories');
const rpCloseBtn = document.getElementById('rpCloseBtn');

const selectorContainer = document.getElementById('selectorContainer');
const selectorTitle = document.getElementById('selectorTitle');
const itemsList = document.getElementById('items');
const selectorCloseBtn = document.getElementById('selectorCloseBtn');

const resourceName = typeof GetParentResourceName === 'function' ? GetParentResourceName() : 'tab-roleplay-system';

function renderRPCategories(categories) {
  rpCategories.innerHTML = '';
  categories.forEach(cat => {
    const div = document.createElement('div');
    div.className = 'category';
    div.textContent = cat.label;
    div.addEventListener('click', () => {
      fetch(`https://${resourceName}/selectCategory`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: cat.value })
      });
    });
    rpCategories.appendChild(div);
  });
}

function renderItems(title, items) {
  selectorTitle.textContent = title;
  itemsList.innerHTML = '';
  items.forEach(item => {
    const div = document.createElement('div');
    div.className = 'item';
    if (item.disabled) div.classList.add('disabled');
    div.textContent = item.label || item.name;
    div.addEventListener('click', () => {
      if (item.disabled) return;
      fetch(`https://${resourceName}/selectItem`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: item.action || null, id: item.id || null })
      });
    });
    itemsList.appendChild(div);
  });
  selectorContainer.style.display = 'flex';
}

function closeRPMenu() {
  rpContainer.style.display = 'none';
  fetch(`https://${resourceName}/closeMenu`, { method: 'POST' });
}

function closeSelector() {
  selectorContainer.style.display = 'none';
  fetch(`https://${resourceName}/closeSelector`, { method: 'POST' });
}

window.addEventListener('message', (event) => {
  const data = event.data;
  switch (data.action) {
    case 'openRPMenu':
      renderRPCategories(data.categories || []);
      rpContainer.style.display = 'flex';
      break;
    case 'openSelector':
      renderItems(data.title || '', data.items || []);
      break;
    case 'closeRPMenu':
      rpContainer.style.display = 'none';
      break;
    case 'closeSelector':
      selectorContainer.style.display = 'none';
      break;
    default:
      break;
  }
});

rpCloseBtn.addEventListener('click', closeRPMenu);
selectorCloseBtn.addEventListener('click', closeSelector);
