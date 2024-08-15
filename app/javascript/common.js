function toggleFilter() {
  const filterContainer = document.querySelector("#filter-container");

  filterContainer.classList.toggle('hide');
  filterContainer.classList.toggle('show');
}

document.querySelector("#open-filter-btn").addEventListener('click', toggleFilter);

document.querySelector("#close-filter-btn").addEventListener('click', toggleFilter);
