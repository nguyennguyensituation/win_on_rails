document.addEventListener('DOMContentLoaded', () => {
  const openFilterBtn = document.getElementById('open-filter-btn');
  const closeFilterBtn = document.getElementById('close-filter-btn');
  const filterPanel = document.getElementById('filter-panel');

  function toggleDisplay(event) {
    filterPanel.classList.toggle('hide');
    event.stopPropagation();
  }

  openFilterBtn.addEventListener('click', toggleDisplay)
  closeFilterBtn.addEventListener('click', toggleDisplay)
})